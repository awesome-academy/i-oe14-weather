//
//  CityManagermentScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class ListCityWeatherViewController: BaseViewController {
    @IBOutlet private weak var listCityCollectionView: UICollectionView!
    
    private var weatherData = [WeatherData]()
    private let listCityRepos = ListCityRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func initData() {
        listCityRepos.fetchData(locations: database.getLocations()) { [weak self] weatherData in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if !weatherData.hasData { return }
                self.weatherData.append(weatherData)
                self.listCityCollectionView.reloadData()
            }
        }
    }
    
    override func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(deleteItemAtIndexPath), name: .deleteItemAtIndexPath, object: nil)
        notificationCenter.addObserver(self, selector: #selector(weatherDataDidChange), name: .weatherDataDidChange, object: nil)
    }
    
    private func configureCollectionView() {
        listCityCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ListCityWeatherCell.self)
        }
    }
    
    @objc private func deleteItemAtIndexPath(_ notification: Notification) {
        guard
            let dictionary = notification.userInfo as? [String: Any],
            let indexPath = dictionary[Constant.keyNotification] as? IndexPath,
            let currentCity = weatherData[indexPath.row].dailyWeather.first
        else {
            return
        }
        
        let deleteMessage = Constant.deleteTitle + currentCity.cityName
        let location = weatherData[indexPath.row].location
        
        showAlertView(title: nil, message: nil,
                      cancelButton: Constant.cancelTitle,
                      otherButtons: [deleteMessage],
                      type: .actionSheet, cancelAction: nil) { [weak self] _ in
            guard let self = self else { return }
                        
            self.weatherData.remove(at: indexPath.row)
            self.database.delete(data: location)
            self.listCityCollectionView.reloadData()
        }
    }
    
    @IBAction private func handleAddButton(_ sender: UIButton) {
        let searchController = SearchLocationViewController.instantiate()
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - CollectionViewDataSource + DelegateFlowLayout
extension ListCityWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListCityWeatherCell.self)
        if let lastData = weatherData[indexPath.row].dailyWeather.last {
            cell.setContentCell(with: lastData, at: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constant.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presentedViewController == nil {
            let viewController = push(PagingCityWeatherViewController.self)
            viewController?.weatherData = weatherData
        }
    }
}

// MARK: - ListCityWeatherViewController
private extension ListCityWeatherViewController {
    struct Constant {
        static let itemSize = CGSize(width: Screen.width / 2, height: Screen.width / 2)
        static let cancelTitle = "Cancel"
        static let deleteTitle = "Delete "
        static let keyNotification = "indexPath"
    }

    @objc func weatherDataDidChange(_ notification: Notification) {
        if let data = notification.object as? WeatherData {
            weatherData.append(data)
            listCityCollectionView.reloadData()
        }
    }
}

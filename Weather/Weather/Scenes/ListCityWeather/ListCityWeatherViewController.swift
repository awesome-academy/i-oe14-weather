//
//  CityManagermentScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

protocol ListCityDelegate: class {
    func updateData(at location: Location)
}

final class ListCityWeatherViewController: UIViewController {
    @IBOutlet private weak var listCityCollectionView: UICollectionView!
    
    private var weatherDatas = [WeatherData]()
    private let dataManager = DataManager.share
    private let listCityRepos = ListCityRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        addObserver()
        configureUICollectionView()
    }
    
    private func initData() {        
        listCityRepos.fetchData(locations: dataManager.getLocations()) { [weak self] weatherData in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if !weatherData.hasData { return }
                self.weatherDatas.append(weatherData)
                self.listCityCollectionView.reloadData()
            }
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteItemAtIndexPath),
                                               name: .deleteItemAtIndexPath,
                                               object: nil)
    }
    
    private func configureUICollectionView() {
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
            let currentCity = weatherDatas[indexPath.row].dailyWeather.first
        else {
            return
        }
        
        let deleteMessage = Constant.deleteTitle + currentCity.cityName
        let location = weatherDatas[indexPath.row].location
        
        showAlertView(title: nil, message: nil,
                      cancelButton: Constant.cancelTitle,
                      otherButtons: [deleteMessage],
                      type: .actionSheet, cancelAction: nil) { [weak self] _ in
            guard let self = self else { return }
                        
            self.weatherDatas.remove(at: indexPath.row)
            self.dataManager.deleteCoreData(with: location)
            self.listCityCollectionView.reloadData()
        }
    }
    
    @IBAction private func handleAddButton(_ sender: UIButton) {
        let searchController = SearchLocationViewController.instantiate()
        searchController.listCityDelegate = self
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - CollectionViewDataSource + DelegateFlowLayout
extension ListCityWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListCityWeatherCell.self)
        if let lastData = weatherDatas[indexPath.row].dailyWeather.last {
            cell.setContentCell(with: lastData, at: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constant.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presentedViewController == nil {
            pushViewController()
        }
    }
}

// MARK: - StoryboardSceneBased
extension ListCityWeatherViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

// MARK: - ListCityDelegate
extension ListCityWeatherViewController: ListCityDelegate {
    func updateData(at location: Location) {
        listCityRepos.fetchData(location: location) { [weak self] weatherData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.weatherDatas.append(weatherData)
                self.listCityCollectionView.reloadData()
            }
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
    
    func pushViewController() {
        let listDetailCity = ListDetailCityWeatherViewController.instantiate()
        navigationController?.pushViewController(listDetailCity, animated: true)
    }
}

//
//  CityManagermentScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class ListCityWeatherViewController: BaseCollectionViewController {
    private let listCityRepos = ListCityRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initData() {
        let locations = database.getLocations(isNeedGps: false)
        listCityRepos.fetchData(locations: locations) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.notificationCenter
                    .post(name: .weatherDataDidChange, object: data)
            case .failed(let error):
                DispatchQueue.main.async {
                    self.showAlertView(title: Constants.warning,
                                       message: error?.errorMessage,
                                       cancelButton: Constants.retry,
                                       otherButtons: [Constants.ok],
                                       type: .alert,
                                       cancelAction: {
                                        self.initData()
                                        }, otherAction: nil)
                }
            }
        }
    }
    
    override func addObserver() {
        super.addObserver()
        notificationCenter.addObserver(self, selector: #selector(deleteItemAtIndexPath), name: .deleteItemAtIndexPath, object: nil)
    }
    
    override func configureCollectionView() {
        super.configureCollectionView()
        baseCollectionView.register(cellType: ListCityWeatherCell.self)
    }
    
    @objc private func deleteItemAtIndexPath(_ notification: Notification) {
        guard
            let dictionary = notification.userInfo as? [String: Any],
            let indexPath = dictionary[Constant.keyNotification] as? IndexPath,
            let currentCity = weatherData[indexPath.row].dailyWeather.first
        else { return }
        
        let message = Constant.message + currentCity.cityName
        let location = weatherData[indexPath.row].location
        showAlertView(title: nil, message: message.question,
                      cancelButton: Constant.cancelTitle,
                      otherButtons: [Constant.deleteTitle],
                      type: .actionSheet, cancelAction: nil) { [weak self] _ in
            guard let self = self else { return }
                        
            self.weatherData.remove(at: indexPath.row)
            self.database.delete(data: location)
            self.baseCollectionView.reloadData()
        }
    }
    
    @IBAction private func handleAddButton(_ sender: UIButton) {
        let searchController = SearchLocationViewController.instantiate()
        present(searchController, animated: true, completion: nil)
    }
}

extension ListCityWeatherViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListCityWeatherCell.self)
        if let lastData = weatherData[indexPath.row].dailyWeather.last {
            cell.setContentCell(with: lastData, at: indexPath)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constant.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if presentedViewController == nil {
            self.push(PagingCityWeatherViewController.self, data: weatherData)
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
        static let message = "Are you sure want delete "
    }
}

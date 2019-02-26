//
//  CityManagermentScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class ListCityWeatherViewController: UIViewController {
    @IBOutlet private weak var listCityCollectionView: UICollectionView!
    
    private var weatherDatas = [WeatherData]()
    private let dataManager = DataManager.share
    private let listCityRepos = ListCityRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        configureUICollectionView()
    }
    
    private func initData() {
        let locations = dataManager.getLocations()
        weatherDatas = [WeatherData](repeating: WeatherData(), count: locations.count)
        
        listCityRepos.fetchData(weatherDatas: &weatherDatas) { [weak self] indexPath in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.listCityCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    private func configureUICollectionView() {
        listCityCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ListCityWeatherCell.self)
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
        return weatherDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListCityWeatherCell.self)
        let weatherData = weatherDatas[indexPath.row].dailyWeather
        cell.setContentCell(with: weatherData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constant.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - StoryboardSceneBased
extension ListCityWeatherViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

// MARK: - ListCityWeatherViewController
extension ListCityWeatherViewController {
    private struct Constant {
        static let itemSize = CGSize(width: Screen.width / 2, height: Screen.width / 2)
    }
}

//
//  BaseTableViewCell.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

class BaseTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var baseCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherData = WeatherData()
    var currentCategories = ForecastCategory.unexpected
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        baseCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    func setContentCell(data: WeatherData, categories: ForecastCategory) {
        baseCollectionView.reloadData()
        weatherData = data
        currentCategories = categories
        descriptionLabel.text = categories.description
    }
}

// MARK: - Datasource - Delegate
extension BaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentCategories {
        case .daily:
            return weatherData.conditions.count
        case .hourly:
            return weatherData.hourlyWeather.count
        case .forecastday:
            return weatherData.forecastdayWeather.count / 2
        case .uv:
            return weatherData.hourlyWeather.count
        default:
            return weatherData.hourlyWeather.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return currentCategories.sizeItem
    }
}

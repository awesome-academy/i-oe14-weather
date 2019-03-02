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
        baseCollectionView.dataSource = self
        baseCollectionView.delegate = self
    }
    
    func setContentCell(data: WeatherData, categories: ForecastCategory) {
        descriptionLabel.text = categories.description
        currentCategories = categories
        weatherData = data
        baseCollectionView.reloadData()
    }
}

// MARK: - Datasource - Delegate
extension BaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentCategories {
        case .daily:
            return weatherData.conditions.count
        default:
            return weatherData.hourlyWeather.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
}

//
//  ForecastdayWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/1/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastdayWeatherCell: BaseTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCollectionView() {
        super.configureCollectionView()
        baseCollectionView.do {
            $0.register(cellType: DailyWeatherCell.self)
            $0.register(cellType: ForecastHourlyWeatherCell.self)
            $0.register(cellType: ForecastdayWeatherCollectionCell.self)
        }
    }
}

extension ForecastdayWeatherCell {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentCategories {
        case .daily:
            let categories = Conditions(row: indexPath.row)
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DailyWeatherCell.self)
            cell.setContentCell(with: weatherData.conditions[indexPath.row], categories: categories)
            return cell
        case .hourly:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastHourlyWeatherCell.self)
            cell.setContentCell(with: weatherData.hourlyWeather[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastdayWeatherCollectionCell.self)
            cell.setContentCell(with: weatherData.forecastdayWeather[indexPath.row], temperature: weatherData.temperature)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return currentCategories.sizeItem
    }
}

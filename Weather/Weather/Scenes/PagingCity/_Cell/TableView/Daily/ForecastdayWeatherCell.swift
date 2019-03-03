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
        baseCollectionView.register(cellType: DailyWeatherCell.self)
        baseCollectionView.register(cellType: ForecastHourlyWeatherCell.self)
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
        case .forecastday:
            return UICollectionViewCell()
        case .uv:
            return UICollectionViewCell()
        case .humidity:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return currentCategories.sizeItem
    }
}

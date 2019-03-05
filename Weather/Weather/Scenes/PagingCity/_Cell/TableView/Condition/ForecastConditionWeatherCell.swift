//
//  ForecastConditionWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/1/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastConditionWeatherCell: BaseTableViewCell {
    @IBOutlet private weak var minChartHeaderLabel: UILabel!
    @IBOutlet private weak var mediumChartHeaderLabel: UILabel!
    @IBOutlet private weak var maxChartHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCollectionView() {
        super.configureCollectionView()
        baseCollectionView.do {
            $0.register(cellType: ForecastUVWeatherCell.self)
            $0.register(cellType: ForecastHumidityWeatherCell.self)
        }
    }
    
    override func setContentCell(data: WeatherData, categories: ForecastCategory) {
        super.setContentCell(data: data, categories: categories)
        setContentChartView(with: categories)
    }
}

extension ForecastConditionWeatherCell {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentCategories {
        case .uv:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastUVWeatherCell.self)
            cell.setContentCell(with: weatherData.hourlyWeather[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ForecastHumidityWeatherCell.self)
            cell.setContentCell(with: weatherData.hourlyWeather[indexPath.row])
            return cell
        }
    }
}

private extension ForecastConditionWeatherCell {
    struct Constant {
        static let contentUV = (min: "0", medium: "5", max: "11+")
        static let contentHumidity = (min: "0%", medium: "50%", max: "100%")
    }
    
    func setContentChartView(with categories: ForecastCategory) {
        switch categories {
        case .uv:
            minChartHeaderLabel.text = Constant.contentUV.min
            mediumChartHeaderLabel.text = Constant.contentUV.medium
            maxChartHeaderLabel.text = Constant.contentUV.max
        default:
            minChartHeaderLabel.text = Constant.contentHumidity.min
            mediumChartHeaderLabel.text = Constant.contentHumidity.medium
            maxChartHeaderLabel.text = Constant.contentHumidity.max
        }
    }
}

//
//  PagingCityWeatherCell.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class PagingCityWeatherCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var viewWeather: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var imageWeather: UIImageView!
    @IBOutlet private weak var forecastWeatherTableView: UITableView!
    
    private var weatherData = WeatherData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    func configureCell(withData data: WeatherData) {
        weatherData = data
        if let weatherData = weatherData.dailyWeather.first {
            configureView(withData: weatherData)
        }
    }
}

// MARK: - Datasource, Delegate
extension PagingCityWeatherCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.maxRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastdayWeatherCell.self)
            cell.setContentCell(data: weatherData, categories: .daily)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastdayWeatherCell.self)
            cell.setContentCell(data: weatherData, categories: .hourly)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastdayWeatherCell.self)
            cell.setContentCell(data: weatherData, categories: .forecastday)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastConditionWeatherCell.self)
            cell.setContentCell(data: weatherData, categories: .uv)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastConditionWeatherCell.self)
            cell.setContentCell(data: weatherData, categories: .humidity)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Constant.dailyHeightRow
        case 1:
            return Constant.dailyHeightRow
        case 2:
            return Constant.forecastdayHeightRow
        case 3:
            return Constant.humidityHeightRow
        default:
            return Constant.humidityHeightRow
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.minHeightHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constant.minHeightHeader
    }
}

// MARK: - ScrollViewDelegate
extension PagingCityWeatherCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scale = (scrollView.contentOffset.y * 2) / viewWeather.bounds.height
        viewWeather.alpha = Constant.maxAlpha - scale
    }
}

// MARK: - PagingCityWeatherCell
private extension PagingCityWeatherCell {
    struct Constant {
        static let maxRow = 5
        static let maxAlpha: CGFloat = 1
        static let minHeightHeader: CGFloat = 0
        static let dailyHeightRow: CGFloat = 200
        static let humidityHeightRow: CGFloat = 220
        static let forecastdayHeightRow: CGFloat = 360
        static let tableHeaderView = UIView(width: 0, height: Screen.height / 2)
    }
    
    func configureTableView() {
        forecastWeatherTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.tableHeaderView = Constant.tableHeaderView
            $0.register(cellType: ForecastdayWeatherCell.self)
            $0.register(cellType: ForecastConditionWeatherCell.self)
        }
    }
    
    func configureView(withData data: ForecastWeather) {
        let weather = Weather(data.weather.icon)
        imageWeather.image = weather.largeImage
        descriptionLabel.text = data.weather.description
        temperatureLabel.text = data.temperature.celsius
        dateLabel.text = "\(data.cityName), " + data.datetime.ddMMyyyy(data.timezone)
    }
}

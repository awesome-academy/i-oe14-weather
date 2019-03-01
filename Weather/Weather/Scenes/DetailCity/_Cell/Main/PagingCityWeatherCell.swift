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
    }
}

// MARK: - Datasource, Delegate
extension PagingCityWeatherCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.maxRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = ForecastMenu(at: indexPath.row)
        
        switch menu {
        case .daily:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastDailyWeatherCell.self)
            return cell
        case .hourly:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastHourlyWeatherCell.self)
            return cell
        case .forecastDay:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastdayWeatherCell.self)
            return cell
        case .humidity:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastHumidityHourlyWeatherCell.self)
            return cell
        case .uv:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastUVHourlyWeatherCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let menu = ForecastMenu(at: indexPath.row)
        
        switch menu {
        case .daily:
            return Constant.dailyHeightRow
        case .hourly:
            return Constant.hourlyHeightRow
        case .forecastDay:
            return Constant.forecastdayHeightRow
        case .uv:
            return Constant.humidityHeightRow
        case .humidity:
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
        let scale = scrollView.contentOffset.y*2/viewWeather.bounds.height
        viewWeather.alpha = Constant.maxAlpha - scale
    }
}

// MARK: - PagingCityWeatherCell
private extension PagingCityWeatherCell {
    struct Constant {
        static let maxRow = 5
        static let maxAlpha: CGFloat = 1
        static let minHeightHeader: CGFloat = 0
        static let dailyHeightRow: CGFloat = 150
        static let hourlyHeightRow: CGFloat = 200
        static let humidityHeightRow: CGFloat = 300
        static let forecastdayHeightRow: CGFloat = 250
        static let tableHeaderView = UIView(width: 0, height: Screen.height / 2)
    }
    
    enum ForecastMenu {
        case daily
        case hourly
        case forecastDay
        case humidity
        case uv
        
        init(at index: Int) {
            switch index {
            case 0:
                self = .daily
            case 1:
                self = .hourly
            case 2:
                self = .forecastDay
            case 3:
                self = .uv
            default:
                self = .humidity
            }
        }
    }
    
    func configureTableView() {
        forecastWeatherTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.tableHeaderView = Constant.tableHeaderView
            $0.register(cellType: ForecastdayWeatherCell.self)
            $0.register(cellType: ForecastDailyWeatherCell.self)
            $0.register(cellType: ForecastHourlyWeatherCell.self)
            $0.register(cellType: ForecastUVHourlyWeatherCell.self)
            $0.register(cellType: ForecastHumidityHourlyWeatherCell.self)
        }
    }
    
    func configureView(withData data: ForecastWeather) {
        let weather = Weather(data.weather.icon)
        imageWeather.image = weather.largeImage
        descriptionLabel.text = data.weather.description
        temperatureLabel.text = data.temperature.celsius
        dateLabel.text = data.datetime
    }
}

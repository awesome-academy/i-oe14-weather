//
//  ListCityWeatherCell.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class ListCityWeatherCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var fadeView: UIView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    private var indexPath = IndexPath(item: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addLongPressGestureRecognizer()
    }
    
    private func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressed)).then {
            $0.cancelsTouchesInView = false
            $0.minimumPressDuration = Constant.maxLongPressDuration
        }
        addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPressed(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            fadeView.backgroundColor = .gray
            deleteItem(at: indexPath)
        case .ended:
            fadeView.backgroundColor = .clear
        default:
            break
        }
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        NotificationCenter.default.post(name: .deleteItemAtIndexPath, object: nil, userInfo: [Constant.keyNotification: indexPath])
    }
    
    private func updateView(withColor: UIColor) {
        mainView.do {
            $0.scaleCornerRadius(Constant.minRatio)
            $0.backgroundColor = withColor
        }
        
        fadeView.do {
            $0.scaleCornerRadius(Constant.minRatio)
            $0.backgroundColor = .clear
        }
        
        shadowView.do {
            $0.backgroundColor = withColor
            $0.scaleCornerRadius(Constant.maxRatio)
            $0.dropShadow(withColor, offSet: Constant.shadowOffset, opacity: Constant.shadowOpacity, radius: Constant.shadowRadius)
        }
    }
    
    private func updateView(with forecastWeather: ForecastWeather) {
        let weather = Weather(forecastWeather.weather.icon)
        cityNameLabel.text = forecastWeather.cityName
        temperatureLabel.text = forecastWeather.temperature.celsius
        weatherImage.image = weather.largeImage
    }
    
    func setContentCell(with forecastWeather: ForecastWeather, at indexPath: IndexPath) {
        self.indexPath = indexPath
        let weather = WeatherColor(code: forecastWeather.weather.code)
        updateView(with: forecastWeather)
        updateView(withColor: weather.backgroundColor)
    }
}

// MARK: - ListCityWeatherCell
extension ListCityWeatherCell {
    private struct Constant {
        static let shadowOffset = CGSize(width: 0, height: 10)
        static let shadowOpacity: Float = 0.4
        static let shadowRadius: CGFloat = 5
        static let minRatio: CGFloat = 0.05
        static let maxRatio: CGFloat = 0.1
        static let maxLongPressDuration: Double = 0.3
        static let keyNotification = "indexPath"
    }
}

//
//  ListCityWeatherCell.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable
import ShadowView

final class ListCityWeatherCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var shadowView: ShadowView!
    @IBOutlet private weak var fadeView: UIView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var shadowImage: UIImageView!
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
        case .began, .changed:
            fadeView.backgroundColor = .gray
            deleteItem(at: indexPath)
        default:
            fadeView.backgroundColor = .clear
        }
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        NotificationCenter.default.post(name: .deleteItemAtIndexPath, object: nil, userInfo: [Constant.keyNotification: indexPath])
    }
    
    private func updateView(with forecastWeather: ForecastWeather) {
        let weather = Weather(forecastWeather.weather.icon)
        let city = CityBackgrounds(forecastWeather.weather.code)
        
        weatherImage.image = weather.largeImage
        shadowImage.image = city.backgroundImage
        cityNameLabel.text = forecastWeather.cityName
        temperatureLabel.text = forecastWeather.temperature.celsius
        shadowView.updateShadow()
        fadeView.scaleCornerRadius(Constant.minRatio)
    }
    
    func setContentCell(with forecastWeather: ForecastWeather, at indexPath: IndexPath) {
        self.indexPath = indexPath
        updateView(with: forecastWeather)
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
        static let maxLongPressDuration: Double = 0.5
        static let keyNotification = "indexPath"
    }
}

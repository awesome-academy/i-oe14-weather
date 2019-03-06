//
//  ForecastdayWeatherCollectionCell.swift
//  Weather
//
//  Created by minh duc on 3/3/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastdayWeatherCollectionCell: BaseCollectionViewCell {
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var topContraint: NSLayoutConstraint!
    @IBOutlet private weak var botContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureSubview() {
        chartView.scaleCornerRadius(0.5)
    }
    
    func setContentCell(with data: ForecastWeather, temperature: (min: Double, max: Double)) {
        let weather = Weather(data.weather.icon)
        weatherImageView.image = weather.smallImage
        maxTempLabel.text = data.maxTemp.celsius
        minTempLabel.text = data.minTemp.celsius
        dayOfWeekLabel.text = data.datetime.dayOfWeek(data.timezone)
        
        var maxRatio: Double = 0
        var minRatio: Double = 0
        
        if data.maxTemp < 0 || data.minTemp < 0 {
            maxRatio = temperature.max >= 0 ? data.maxTemp / (temperature.max - data.maxTemp * 2) : temperature.max / data.maxTemp
            minRatio = temperature.min >= 0 ? data.minTemp / (temperature.min - data.minTemp * 2) : temperature.min / data.minTemp
            
            maxRatio = min(1, maxRatio < 0 ? -maxRatio : maxRatio)
            minRatio = min(1, minRatio < 0 ? -minRatio : minRatio)
        } else {
            maxRatio = data.maxTemp / temperature.max
            minRatio = data.minTemp / temperature.min
        }
        topContraint.constant = min(Constant.minHeight, Constant.maxHeight - (CGFloat(maxRatio) * Constant.maxHeight))
        botContraint.constant = min(Constant.minHeight, Constant.maxHeight - (CGFloat(minRatio) * Constant.maxHeight))
    }
}

private extension ForecastdayWeatherCollectionCell {
    struct Constant {
        static let maxHeight: CGFloat = 70
        static let minHeight: CGFloat = 60
    }
}

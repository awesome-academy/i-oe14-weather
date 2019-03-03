//
//  ForecastHourlyWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/3/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastHourlyWeatherCell: BaseCollectionViewCell {
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var conditionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentCell(with data: ForecastWeather) {
        let weather = Weather(data.weather.icon)
        temperatureLabel.text = data.temperature.celsius
        timeLabel.text = data.datetime.hh(data.timezone)
        conditionImageView.image = weather.smallImage
    }
}

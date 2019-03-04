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
        chartView.do {
            $0.scaleCornerRadius(0.5)
        }
    }
    
    func setContentCell(with data: ForecastWeather, temperature: (min: Double, max: Double)) {
        let weather = Weather(data.weather.icon)
        weatherImageView.image = weather.smallImage
        maxTempLabel.text = data.maxTemperature.celsius
        minTempLabel.text = data.minTemperature.celsius
        dayOfWeekLabel.text = data.datetime.dayOfWeek(data.timezone)
        
        let ratioMaxTemp = data.maxTemperature.rounded() / temperature.max.rounded()
        let ratioMinTemp = data.minTemperature.rounded() / temperature.min.rounded()
        topContraint.constant = CGFloat(Constant.heightChart - (ratioMaxTemp * Constant.heightChart))
        botContraint.constant = CGFloat(Constant.heightChart - (ratioMinTemp * Constant.heightChart))
    }
}

private extension ForecastdayWeatherCollectionCell {
    struct Constant {
        static let heightChart: Double = 70
    }
}

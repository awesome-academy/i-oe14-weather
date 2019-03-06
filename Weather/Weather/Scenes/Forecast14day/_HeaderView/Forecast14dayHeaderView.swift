//
//  Forecast14dayHeaderView.swift
//  Weather
//
//  Created by minh duc on 3/6/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class Forecast14dayHeaderView: UIView, NibLoadable {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var expandButon: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setContentView(with data: ForecastWeather) {
        let weather = Weather(data.weather.icon)
        let temperature = "\(data.minTemp.celsius) / \(data.maxTemp.celsius)"
        weatherImageView.image = weather.largeImage
        descriptionLabel.text = data.weather.description
        dateLabel.text = data.datetime.fullDayOfWeek(data.timezone) + "\n\(temperature)"
    }
    
    func configureSubview(_ target: BaseViewController, section: Int, selector: Selector) {
        expandButon.do {
            $0.tag = section
            $0.addTarget(target, action: selector, for: .touchUpInside)
        }
        mainView.setCornerRadius(8, color: .clear)
    }
}

//
//  ForecastHumidityWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/5/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastHumidityWeatherCell: BaseCollectionViewCell {
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var heightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureSubview() {
        chartView.setCornerRadius(Constant.radius, border: Constant.border)
    }
    
    func setContentCell(with data: ForecastWeather) {
        dateLabel.text = data.datetime.hh(data.timezone)
        heightContraint.constant = CGFloat(data.humidity - Constant.marginTop)
    }
}

private extension ForecastHumidityWeatherCell {
    struct Constant {
        static let marginTop = 10
        static let radius: CGFloat = 7.5
        static let border: CGFloat = 1
    }
}

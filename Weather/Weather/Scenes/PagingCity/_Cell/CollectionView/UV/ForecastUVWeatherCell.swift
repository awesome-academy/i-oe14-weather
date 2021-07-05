//
//  ForecastUVWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/4/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class ForecastUVWeatherCell: BaseCollectionViewCell {
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var heightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureSubview() {
        chartView.scaleCornerRadius(0.2)
    }
    
    func setContentCell(with data: ForecastWeather) {
        dateLabel.text = data.datetime.hh(data.timezone)
        
        chartView.do {
            if data.uv >= 0 && data.uv < 2.5 {
                $0.backgroundColor = .minUV
            } else if data.uv >= 2.5 && data.uv < 7.5 {
                $0.backgroundColor = .mediumUV
            } else {
                $0.backgroundColor = .maxUV
            }
        }
        
        let ratio = data.uv / Constant.maxUV
        heightContraint.constant = CGFloat(ratio * Constant.heightChart)
    }
}

private extension ForecastUVWeatherCell {
    struct Constant {
        static let heightChart: Double = 100
        static let maxUV: Double = 11
    }
}

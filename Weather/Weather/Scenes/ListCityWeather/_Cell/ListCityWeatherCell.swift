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
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViewWithColor(.rain)
    }
    
    private func configViewWithColor(_ color: UIColor) {
        mainView.do {
            $0.scaleCornerRadius(Constant.minRatio)
            $0.backgroundColor = color
        }
        
        shadowView.do {
            $0.scaleCornerRadius(Constant.maxRatio)
            $0.dropShadow(color, offSet: Constant.shadowOffset, opacity: Constant.shadowOpacity, radius: Constant.shadowRadius)
        }
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
    }
}

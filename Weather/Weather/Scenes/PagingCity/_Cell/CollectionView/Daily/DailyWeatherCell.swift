//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class DailyWeatherCell: BaseCollectionViewCell {
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureSubview() {
        mainView.scaleCornerRadius(0.1)
    }
    
    func setContentCell(with condition: String, categories: Conditions) {
        valueLabel.text = condition
        contentLabel.text = categories.description
        contentImageView.image = categories.image
        mainView.backgroundColor = categories.backgroundColor
    }
}

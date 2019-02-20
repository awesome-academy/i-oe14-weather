//
//  SearchLocationCell.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class SearchLocationCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(prediction: Prediction) {
        descriptionLabel.text = prediction.description
    }
}

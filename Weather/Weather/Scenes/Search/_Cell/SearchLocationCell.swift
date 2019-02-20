//
//  SearchLocationCell.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

class SearchLocationCell: UITableViewCell, NibReusable {
    @IBOutlet weak var label_description: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(object: Prediction) {
        self.label_description?.text = object.description
    }
}

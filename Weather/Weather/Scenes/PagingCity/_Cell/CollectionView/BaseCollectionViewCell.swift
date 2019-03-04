//
//  BaseCollectionViewCell.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

class BaseCollectionViewCell: UICollectionViewCell, NibReusable {
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSubview()
    }
    
    func configureSubview() { }
}

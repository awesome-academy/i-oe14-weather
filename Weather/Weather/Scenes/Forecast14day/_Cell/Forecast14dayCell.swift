//
//  Forecast14dayCell.swift
//  Weather
//
//  Created by minh duc on 3/6/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class Forecast14dayCell: BaseTableViewCell {
    private var conditions = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configureCollectionView() {
        super.configureCollectionView()
        baseCollectionView.do {
            $0.register(cellType: DailyWeatherCell.self)
        }
    }
    
    func setContentCell(with data: [String]) {
        super.setContentCell(data: WeatherData(), categories: .daily)
        conditions = data
        baseCollectionView.reloadData()
    }
}

extension Forecast14dayCell {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categories = Conditions(row: indexPath.row)
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DailyWeatherCell.self)
        cell.setContentCell(with: conditions[indexPath.row], categories: categories)
        return cell
    }
}

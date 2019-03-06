//
//  BaseCollectionViewController.swift
//  Weather
//
//  Created by minh duc on 3/7/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseCollectionViewController: BaseViewController {
    @IBOutlet weak var baseCollectionView: UICollectionView!
    var weatherData = [WeatherData]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        baseCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    @objc func weatherDataDidChange(_ notification: Notification) {
        DispatchQueue.main.async {
            if let data = notification.object as? WeatherData {
                self.weatherData.append(data)
                self.baseCollectionView.reloadData()
            }
        }
    }
    
    override func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(weatherDataDidChange), name: .weatherDataDidChange, object: nil)
    }
}

// MARK: - CollectionViewDataSource + DelegateFlowLayout
extension BaseCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: baseCollectionView.bounds.width, height: baseCollectionView.bounds.height)
    }
}

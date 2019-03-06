//
//  PagingCityWeatherViewController.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class PagingCityWeatherViewController: BaseViewController {
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var weatherCollectionView: UICollectionView!
    
    var weatherData = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    override func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(weatherDataDidChange), name: .weatherDataDidChange, object: nil)
        notificationCenter.addObserver(self, selector: #selector(presentViewController), name: .presentViewController, object: nil)
    }
    
    @IBAction private func handleBackButton(_ sender: UIButton) {
        popViewController()
    }
}

// MARK: - UICollectionViewDataSource + UICollectionViewFlowLayout
extension PagingCityWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PagingCityWeatherCell.self)
        cell.configureCell(withData: weatherData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - PagingCityWeatherViewController
private extension PagingCityWeatherViewController {
    func configureCollectionView() {
        weatherCollectionView.do {
            $0.register(cellType: PagingCityWeatherCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
        
        pageControl.do {
            $0.numberOfPages = weatherData.count
        }
    }
    
    @objc func weatherDataDidChange(_ notification: Notification) {
        if let data = notification.object as? WeatherData {
            weatherData.append(data)
            weatherCollectionView.reloadData()
        }
    }
    
    @objc func presentViewController(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if let self = self,
                let weatherData = notification.object as? WeatherData {
                let viewController = Forecast14dayViewController.instantiate()
                viewController.weatherData = weatherData
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - ScrollViewDelegate
extension PagingCityWeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / Screen.width)
        pageControl.currentPage = currentPage
    }
}

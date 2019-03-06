//
//  PagingCityWeatherViewController.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class PagingCityWeatherViewController: BaseCollectionViewController {
    @IBOutlet private weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    override func addObserver() {
        super.addObserver()
        notificationCenter.addObserver(self, selector: #selector(presentViewController), name: .presentViewController, object: nil)
    }
    
    override func configureCollectionView() {
        super.configureCollectionView()
        baseCollectionView.register(cellType: PagingCityWeatherCell.self)
        pageControl.numberOfPages = weatherData.count
    }
    
    override func weatherDataDidChange(_ notification: Notification) {
        super.weatherDataDidChange(notification)
        DispatchQueue.main.async {
            self.pageControl.numberOfPages = self.weatherData.count
        }
    }
    
    @IBAction private func handleBackButton(_ sender: UIButton) {
        popViewController()
    }
}

// MARK: - UICollectionViewDataSource + UICollectionViewFlowLayout
extension PagingCityWeatherViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PagingCityWeatherCell.self)
        cell.configureCell(withData: weatherData[indexPath.row])
        return cell
    }
}

// MARK: - PagingCityWeatherViewController
private extension PagingCityWeatherViewController {
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
extension PagingCityWeatherViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / Screen.width)
        pageControl.currentPage = currentPage
    }
}

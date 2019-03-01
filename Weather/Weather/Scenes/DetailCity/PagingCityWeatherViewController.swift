//
//  PagingCityWeatherViewController.swift
//  Weather
//
//  Created by minh duc on 2/28/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class PagingCityWeatherViewController: UIViewController {
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var weatherCollectionView: UICollectionView!
    
    var weatherData = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        configureUICollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObserver()
    }
    
    @IBAction private func handleBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
    func configureUICollectionView() {
        weatherCollectionView.do {
            $0.register(cellType: PagingCityWeatherCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
        
        pageControl.do {
            $0.numberOfPages = weatherData.count
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(weatherDataDidChange),
                                               name: .weatherDataDidChange,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func weatherDataDidChange(_ notification: Notification) {
        if let data = notification.object as? WeatherData {
            weatherData.append(data)
            weatherCollectionView.reloadData()
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

// MARK: - StoryboardSceneBased
extension PagingCityWeatherViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

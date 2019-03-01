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
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var weatherDatas = [WeatherData]()
    
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
        return weatherDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DetailCityWeatherCell.self)
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
            $0.register(cellType: DetailCityWeatherCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
        
        pageControl.do {
            $0.numberOfPages = weatherDatas.count
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
        if let weatherData = notification.object as? WeatherData {
            weatherDatas.append(weatherData)
            weatherCollectionView.reloadData()
        }
    }
}

// MARK: - StoryboardSceneBased
extension PagingCityWeatherViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

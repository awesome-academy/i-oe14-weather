//
//  CityManagermentScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/25/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable

final class ListCityWeatherViewController: UIViewController, StoryboardSceneBased {
    @IBOutlet private weak var listCityCollectionView: UICollectionView!
    
    private struct Constant {
        static let itemSize = CGSize(width: Constants.widthScreen/2, height: Constants.widthScreen/2)
    }
    
    static let sceneStoryboard = UIStoryboard(name: Constants.nameStoryboard, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    private func configCollectionView() {
        listCityCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ListCityWeatherCell.self)
        }
    }
    
    @IBAction private func addItemButtonTapped(_ sender: UIButton) {
        let searchController = SearchLocationViewController.instantiate()
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - CollectionViewDataSource + DelegateFlowLayout
extension ListCityWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListCityWeatherCell.self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constant.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

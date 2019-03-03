//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reusable

final class SearchLocationViewController: BaseTableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let searchRepo = SearchRepository()
    private let weatherRepo = ListCityRepository()
    private var predictions = [Prediction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureSubview() {
        searchBar.do {
            $0.delegate = self
            $0.becomeFirstResponder()
            $0.setTextFieldColor(.white)
        }
    }
    
    override func configureTableView() {
        super.configureTableView()
        baseTableView.do {
            $0.register(cellType: SearchLocationCell.self)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: UIButton) {
        dismissViewController()
    }
    
    private func dismissViewController() {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Override
extension SearchLocationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchLocationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(prediction: predictions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        startLoading()
        
        let placeId = predictions[indexPath.row].placeId
        searchRepo.searchCoordinate(of: placeId) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let location = Location(placeId: placeId, coordinate: data.coordinate)
                    self.postNotification(with: location)
                case .failed(let error):
                    self.showErrorMessage(message: error?.errorMessage)
                    self.stopLoading()
                }
            }
        }
    }
    
    func postNotification(with location: Location) {
        if database.contains(location) {
            stopLoading()
            dismissViewController()
        } else {
            weatherRepo.fetchData(location: location) { [weak self] weatherData in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.notificationCenter.post(name: .weatherDataDidChange,
                                                 object: weatherData)
                    self.stopLoading()
                    self.dismissViewController()
                }
            }
        }
    }
}

// MARK: - SearchBarDelegate
extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepo.searchLocation(keyword: searchText.ascii) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self.predictions = data.predictions
                    self.loadingSuccess()
                case .failed(let error):
                    self.predictions.removeAll()
                    self.loadingFailed(error?.errorMessage)
                }
            }
        }
    }
}

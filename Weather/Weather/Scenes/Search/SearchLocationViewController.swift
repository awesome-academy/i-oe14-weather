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

final class SearchLocationViewController: BaseTableViewController, StoryboardSceneBased {
    @IBOutlet private weak var searchBar: UISearchBar!
    
    static let sceneStoryboard = UIStoryboard(name: Constants.nameStoryboard, bundle: nil)
    private let searchRepo = SearchRepository()
    private var predictions = [Prediction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        searchBar.do {
            $0.delegate = self
            $0.becomeFirstResponder()
            $0.setTextFieldColor(.white)
        }
    }
    
    override func configTableView() {
        super.configTableView()
        baseTableView.do {
            $0.register(cellType: SearchLocationCell.self)
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
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
            switch result {
            case .success(let data):
                guard let _ = data else { return }
            case .failed(let error):
                self.showErrorMessage(message: error?.errorMessage)
            }
            self.stopLoading()
        }
    }
}

// MARK: - SearchBarDelegate
extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepo.searchLocation(keyword: searchText.ascii) { [weak self] result in
            guard let self = self else { return }
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

//
//  SearchLocationViewController.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class SearchLocationViewController: BaseTableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    
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
}
// MARK: - SearchBarDelegate
extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepo.searchLocation(keyword: searchText.ascii) { [weak self] result in
            guard let owner = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                owner.predictions = data.predictions
                owner.loadingSuccess()
            case .failed(let error):
                owner.predictions.removeAll()
                owner.loadingFailed(error?.errorMessage)
            }
        }
    }
}

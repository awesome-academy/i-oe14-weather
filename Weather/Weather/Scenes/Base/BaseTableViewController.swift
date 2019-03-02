//
//  BaseTableViewController.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Then

class BaseTableViewController: BaseViewController {
    @IBOutlet weak var baseTableView: UITableView!
    
    private struct Constant {
        static let minHeight: CGFloat = 50
    }
    
    private let resultLabel = UILabel().then {
        $0.frame = CGRect(width: 0, height: Constant.minHeight)
        $0.textColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func loadingSuccess() {
        baseTableView.do {
            $0.tableHeaderView = nil
            $0.reloadData()
        }
    }
    
    func loadingFailed(_ message: String?) {
        resultLabel.text = message
        baseTableView.do {
            $0.tableHeaderView = resultLabel
            $0.reloadData()
        }
    }
    
    func configureTableView() {
        baseTableView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
}

// MARK: - UITableViewDataSource + UITableViewDelegate
extension BaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.minHeight
    }
}

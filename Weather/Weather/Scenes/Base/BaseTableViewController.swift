//
//  BaseTableViewController.swift
//  Weather
//
//  Created by minh duc on 2/19/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Then

class BaseTableViewController: UIViewController {
    @IBOutlet weak var tbvBase: UITableView?
    private let labelResult = UILabel(height: 50).then {
        $0.textColor = .white
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseTableViewController {
    func loadingSuccess() {
        self.tbvBase?.tableHeaderView = nil
        self.tbvBase?.reloadData()
    }
    
    func loadingFailed(_ message: String?) {
        labelResult.text = message
        self.tbvBase?.tableHeaderView = labelResult
        self.tbvBase?.reloadData()
    }
}

//MARK: - UITableViewDataSource + UITableViewDelegate
extension BaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

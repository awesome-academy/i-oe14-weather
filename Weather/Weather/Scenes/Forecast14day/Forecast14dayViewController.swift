//
//  Forecast14dayViewController.swift
//  Weather
//
//  Created by minh duc on 3/5/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit

final class Forecast14dayViewController: BaseTableViewController {
    var weatherData = WeatherData()
    private var currentSection = Constant.minSection
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureTableView() {
        super.configureTableView()
        baseTableView.register(cellType: Forecast14dayCell.self)
    }
    
    @IBAction private func handleDoneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension Forecast14dayViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherData.forecastdayWeather.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.numberOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: Forecast14dayCell.self)
        cell.setContentCell(with: weatherData.condition14days[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Forecast14dayHeaderView.loadFromNib().then {
            $0.configureSubview(self,
                                section: section,
                                selector: #selector(handleExpandRow))
            $0.setContentView(with: weatherData.forecastdayWeather[section])
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isOpen = currentSection == indexPath.section
        return isOpen ? Constant.maxHeight : Constant.minHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.maxHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constant.minHeightFooter
    }
}

private extension Forecast14dayViewController {
    struct Constant {
        static let numberOfRow = 1
        static let minSection = -1
        static let minHeight: CGFloat = 0
        static let maxHeight: CGFloat = 120
        static let minHeightFooter: CGFloat = 5
    }
    
    @objc func handleExpandRow(_ sender: UIButton) {
        let isOpen = currentSection == sender.tag
        let indexPath = IndexPath(item: 0, section: sender.tag)
        
        currentSection = isOpen ? Constant.minSection : sender.tag
        baseTableView.reloadRows(at: [indexPath], with: .fade)
    }
}

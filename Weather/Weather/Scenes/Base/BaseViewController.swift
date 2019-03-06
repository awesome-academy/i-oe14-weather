//
//  BaseViewController.swift
//  Weather
//
//  Created by minh duc on 3/2/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import Reusable
import MBProgressHUD
import ObjectMapper

class BaseViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let database = Database.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        addObserver()
        configureSubview()
    }
    
    deinit {
        removeAllObserver()
    }
    
    func initData() { }
    
    func configureSubview() { }
    
    func push<T: BaseViewController>(_ viewController: T, animated: Bool = true) {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func push<T: BaseCollectionViewController>(_ viewController: T.Type, data: [WeatherData], animated: Bool = true) {
        let viewController = T.instantiate()
        viewController.weatherData = data
        push(viewController, animated: animated)
    }
    
    func popViewController() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    func addObserver() { }
    
    func removeAllObserver() {
        notificationCenter.removeObserver(self)
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

// MARK: - StoryboardSceneBased
extension BaseViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

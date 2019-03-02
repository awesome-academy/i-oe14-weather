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
    
    @discardableResult
    func push<T: BaseViewController>(_ viewController: T.Type) -> T? {
        guard let navigationController = navigationController else {
            return nil
        }
        let controller = viewController.instantiate()
        navigationController.pushViewController(controller, animated: true)
        return controller
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
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension BaseViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboard.main
}

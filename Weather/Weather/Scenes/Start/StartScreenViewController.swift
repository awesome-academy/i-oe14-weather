//
//  StartScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/23/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import CoreLocation
import Then

final class StartScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func locationServicesEnable(_ sender: UIButton) {
        // allow access location services
    }
}
// Mark: - CLLocationManagerDelegate
extension StartScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            break
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        // update last location
    }
}

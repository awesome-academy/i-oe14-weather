//
//  StartScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/23/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import CoreLocation
import Reusable

final class StartScreenViewController: UIViewController {
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let dataManager = DataManager.share
    
    private struct Constant {
        static let distance: CLLocationDistance = 5
        static let placeId = "placeId"
    }

    private let locationManager = CLLocationManager().then {
        $0.desiredAccuracy = kCLLocationAccuracyKilometer
        $0.distanceFilter = Constant.distance  // In kilometer.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    private func configLocationView(_ isHidden: Bool) {
        locationView.isHidden = !isHidden
        activityIndicator.isHidden = isHidden
    }
    
    private func updateData(with location: Location?) {
        configLocationView(false)
        guard let location = location else { return }
        dataManager.updateCoreData(with: location)
    }
    
    @IBAction private func handleLocationButton(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction private func handleSkipButton(_ sender: UIButton) {
        configLocationView(false)
    }
    
    private func pushViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let cityController = ListCityWeatherViewController.instantiate()
            self.navigationController?.pushViewController(cityController, animated: true)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension StartScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            updateData(with: nil)
        case .authorizedWhenInUse:
            startReceivingLocationChanges()
        case .notDetermined, .authorizedAlways:
            configLocationView(true)
        }
        pushViewController()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard
            let latitude = locations.last?.coordinate.latitude,
            let longitude = locations.last?.coordinate.longitude
        else {
            return locationManager.stopUpdatingLocation()
        }
        let coordinate = Coordinate(lat: latitude, lng: longitude)
        let location = Location(placeId: Constant.placeId, coordinate: coordinate)
        
        locationManager.stopUpdatingLocation()
        updateData(with: location) // Save in core data
    }
    
    private func startReceivingLocationChanges() {
        configLocationView(false)
        if !CLLocationManager.locationServicesEnabled() {
            return updateData(with: nil) // Location services is not available.
        }
        locationManager.startUpdatingLocation()
    }
}

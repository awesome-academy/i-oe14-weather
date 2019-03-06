//
//  StartScreenViewController.swift
//  Weather
//
//  Created by minh duc on 2/23/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

import UIKit
import CoreLocation

final class StartScreenViewController: BaseViewController {
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private struct Constant {
        static let distance: CLLocationDistance = 5
        static let placeId = "placeId"
        static let timeOut: DispatchTime = .now() + 0.5
    }
    
    private var pushedViewController = false
    private let weatherRepos = ListCityRepository()
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
        if let location = location, !pushedViewController {
            fetchData(at: location)
            database.insert(location)
        } else if !pushedViewController {
            push(after: Constant.timeOut)
        }
    }
    
    private func fetchData(at location: Location) {
        pushedViewController = true
        weatherRepos.fetchData(location: location) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data = data else { return }
                    self.push(ListCityWeatherViewController.self, data: [data])
                case .failed(let error):
                    self.showAlertView(title: Constants.warning,
                                       message: error?.errorMessage,
                                       cancelButton: Constants.retry,
                                       type: .alert,
                    cancelAction: {
                        self.pushedViewController = false
                        self.startReceivingLocationChanges()
                    })
                }
            }
        }
    }
    
    @IBAction private func handleLocationButton(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction private func handleSkipButton(_ sender: UIButton) {
        configLocationView(false)
        push(after: .now())
    }

    private func push(after timeOut: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: timeOut) {
            self.push(ListCityWeatherViewController.instantiate())
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
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard
            let latitude = locations.last?.coordinate.latitude,
            let longitude = locations.last?.coordinate.longitude
        else {
            return locationManager.stopUpdatingLocation()
        }
        let coordinate = Coordinate(lat: latitude, lng: longitude)
        let location = Location(Constant.placeId, coordinate: coordinate)
        
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

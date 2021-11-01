//
//  LocationManagerService.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 31/10/21.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationUpdate(latitude: Double, longtitude: Double)
}

class LocationManagerService: NSObject {
    
    private var locationManager: CLLocationManager?
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }
    
    func getUserLocation() {
        locationManager?.startUpdatingLocation()
    }
}

extension LocationManagerService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = Double(location.coordinate.latitude)
            let longtitude = Double(location.coordinate.longitude)
            if let delegate = self.delegate {
                delegate.locationUpdate(latitude: latitude, longtitude: longtitude)
            }
        }
    }
}

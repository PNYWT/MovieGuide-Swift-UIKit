//
//  LocationManager.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import Foundation
import CoreLocation

//MARK: use to find movie theatre in future
class LocationManager :NSObject{
    var locationManager:CLLocationManager? = nil
    
    override init() {
        super.init()
        showLocationPermission()
    }
    
    func showLocationPermission(){
        locationManager = CLLocationManager.init()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
}

extension LocationManager:CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            print("authorizedAlways")
        }else{
            print(status)
        }
    }
}

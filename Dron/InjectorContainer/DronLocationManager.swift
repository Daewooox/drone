//
//  DronLocationManager.swift
//  Dron
//
//  Created by Dmtech on 22.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit
import CoreLocation

protocol DronLocationManagerInjection {
    var dronServerProvider: DronServerProviderProtocol { get set };
}

protocol DronLocationManagerProtocol {
    func start() -> Void
    func getLastLocation() -> CLLocationCoordinate2D
}

class DronLocationManager: NSObject, DronLocationManagerProtocol, CLLocationManagerDelegate {
    var injection : DronLocationManagerInjection?
    var locationManager : CLLocationManager!
    var lastLocation : CLLocation?
    
    init(aInjection:DronLocationManagerInjection) {
        injection = aInjection;
    }
    
    func start() -> Void {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 5
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        self.lastLocation = userLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.injection?.dronServerProvider.sendUpdatingLocation(location: userLocation.coordinate)
    }
    
    
    func getLastLocation() -> CLLocationCoordinate2D {
        if (lastLocation != nil) {
            return (lastLocation?.coordinate)!
        }
        else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

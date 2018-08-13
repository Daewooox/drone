//
//  DronUserLocationViewController.swift
//  Dron
//
//  Created by Alexander on 20.07.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Reachability

class DronUserLocationViewController: UIViewController {
    
    var userLocation: CLLocationCoordinate2D? = InjectorContainer.shared.dronLocationManager.getLastLocation()
    lazy var closeButton = UIButton(frame: CGRect.zero)
    lazy var mapView = MKMapView(frame: CGRect.zero)
    lazy var goButton = UIButton(frame: CGRect.zero)
    lazy var limitRegion: MKCoordinateRegion = {
        let regionRadius: CLLocationDistance = 1000
        var coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.centerCoordinate, regionRadius, regionRadius)
        if let userLocation = userLocation {
           coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation, regionRadius, regionRadius)
        }
        return coordinateRegion
    }()
    lazy var longGesture: UIGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(addNewPin(longGesture:)))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector:#selector(checkAuthStatus), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAuthStatus()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.setTitle(NSLocalizedString("GO", comment: "GO"), for: .normal)
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        self.view.addSubview(goButton)
        
        goButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        goButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        goButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        goButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mapView.addGestureRecognizer(longGesture)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.backgroundColor = UIColor.clear
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.hybrid
        self.view.addSubview(mapView)
        
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: 0).isActive = true
        
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(UIColor.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeButton)
        
        closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func checkAuthStatus() {
        let status = InjectorContainer.shared.dronLocationManager.getAuthStatus()
        if status == .denied || status == .restricted || status == .notDetermined {
            goButton.isEnabled = false
            goButton.setTitleColor(UIColor.white, for: .normal)
            goButton.backgroundColor = UIColor.lightGray
            mapView.removeAnnotations(mapView.annotations)
            longGesture.isEnabled = false
            userLocation = nil
            InjectorContainer.shared.dronLocationManager.stop()
            let alert = UIAlertController(title: "Access to Location Services denied", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: { (action) -> Void in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                }
            })
            let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel") , style: .cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            if userLocation == nil {
                InjectorContainer.shared.dronLocationManager.start()
                userLocation = InjectorContainer.shared.dronLocationManager.getLastLocation()
                limitRegion.center = userLocation!
                mapView.setRegion(limitRegion, animated: true)
            }
            longGesture.isEnabled = true
            goButton.isEnabled = true
            goButton.backgroundColor = UIColor.green
            goButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    func setupMapViewWithAnnotation(userLocation: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation();
        annotation.coordinate = userLocation;
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, _) in
            annotation.title = NSLocalizedString("Your address:", comment: "Your address:")
            annotation.subtitle = self.getAddressString(placemark: (placemarks?.first)!)
            DispatchQueue.main.async {
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation);
                for annotation in self.mapView.annotations {
                    if annotation .isKind(of: MKPointAnnotation.self) {
                        self.mapView.selectAnnotation(annotation, animated: true)
                        self.mapView.setNeedsDisplay()
                    }
                }
            }
        }
    }
    
    func getAddressString(placemark: CLPlacemark) -> String? {
        var originAddress : String?
        if let addrList = placemark.addressDictionary?["FormattedAddressLines"] as? [String] {
            originAddress =  addrList.joined(separator: ", ")
        }
        return originAddress
    }
    
    @objc func addNewPin(longGesture : UIGestureRecognizer) {
        if longGesture.state == UIGestureRecognizerState.began {
            let touchPoint = longGesture.location(in: mapView)
            let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            if getDistanceFromCoordinates(firstCoordinate: mapView.userLocation.coordinate, secondCoordinate: location) <= 1000 {
                setupMapViewWithAnnotation(userLocation: location)
            } else {
                InjectorContainer.shared.dronUIManager.showInfoBanner(text: NSLocalizedString("This point is further than 1 km", comment: "This point is further than 1 km"))
            }
        }
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goButtonTapped() {
        goButton.isEnabled = false
        var userCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        if self.mapView.annotations.count > 1 {
            for annotation in self.mapView.annotations {
                if annotation .isKind(of: MKPointAnnotation.self) {
                    userCoordinate = annotation.coordinate
                }
            }
        } else {
            userCoordinate = self.mapView.userLocation.coordinate
        }
        InjectorContainer.shared.dronServerProvider.addSosRequest(location: userCoordinate) { (responce, error) -> (Void) in
            if error == nil {
                self.dismiss(animated: true) {}
            } else {
                self.goButton.isEnabled = true
            }
        }
    }
    
    func getDistanceFromCoordinates(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let first = CLLocation(latitude: firstCoordinate.latitude, longitude: firstCoordinate.longitude)
        let second = CLLocation(latitude: secondCoordinate.latitude, longitude: secondCoordinate.longitude)
        return first.distance(from: second)
    }
}

extension DronUserLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {    
        let reuseIdentifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.canShowCallout = true
        annotationView?.isEnabled = true
        if mapView.annotations.count > 1 {
            annotationView?.image = UIImage(named: "map-marker")
        } else {
            annotationView?.image = UIImage(named: "map-marker-for-user")
        }
        
        if annotation.isKind(of: MKUserLocation.self) &&  Reachability()?.connection != .none {
            let location = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, _) in
                if placemarks != nil {
                    mapView.userLocation.title = NSLocalizedString("Your address:", comment: "Your address:")
                    mapView.userLocation.subtitle = self.getAddressString(placemark: (placemarks?.first)!)
                    DispatchQueue.main.async {
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if userLocation != nil {
            if getDistanceFromCoordinates(firstCoordinate: mapView.userLocation.coordinate, secondCoordinate: mapView.centerCoordinate) > 1000 {
                if mapView.userLocation.coordinate.latitude != 0 {
                    limitRegion.center = mapView.userLocation.coordinate
                }
                mapView.setRegion(limitRegion, animated: true)
            }
        }
    }
}

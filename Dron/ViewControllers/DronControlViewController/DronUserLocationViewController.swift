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

class DronUserLocationViewController: UIViewController {
    
    lazy var closeButton = UIButton(frame: CGRect.zero)
    lazy var mapView = MKMapView(frame: CGRect.zero)
    lazy var goButton = UIButton(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapViewWithAnnotation(userLocation: InjectorContainer.shared.dronLocationManager.getLastLocation())
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.backgroundColor = UIColor.green
        goButton.setTitle("GO", for: .normal)
        goButton.setTitleColor(UIColor.black, for: .normal)
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        self.view.addSubview(goButton)
        
        goButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        goButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        goButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        goButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addNewPin(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.backgroundColor = UIColor.clear
        mapView.delegate = self
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
    
    func setupMapViewWithAnnotation(userLocation: CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 1000, 1000)
        mapView.setRegion(viewRegion, animated: false)
        let annotation = MKPointAnnotation();
        annotation.coordinate = userLocation;
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, _) in
            annotation.title = self.getAddressString(placemark: (placemarks?.first)!)
            DispatchQueue.main.async {
                self.mapView.selectAnnotation(self.mapView.annotations[0], animated: true)
            }
        }
        mapView.addAnnotation(annotation);
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
            mapView.removeAnnotations(mapView.annotations)
            let touchPoint = longGesture.location(in: mapView)
            let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            setupMapViewWithAnnotation(userLocation: location)
        }
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goButtonTapped() {
        self.dismiss(animated: true) {
            InjectorContainer.shared.dronServerProvider.addSosRequest(location: (self.mapView.annotations.first?.coordinate)!)
        }
    }
}

extension DronUserLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {    
        let reuseIdentifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.isEnabled = true
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "map-marker")
        
        return annotationView
    }
}



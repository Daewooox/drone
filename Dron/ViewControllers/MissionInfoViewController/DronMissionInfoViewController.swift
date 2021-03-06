//
//  DronMissionInfoViewController.swift
//  Dron
//
//  Created by Alexander on 18.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DronMissionInfoViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView?
    var dronMissionInfoView: DronMissionInfoView?
    var dronInfoViewModel: DronMissionInfoViewModel?
    var missionInfoDTO: DronMissionInfoDTO?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    
    func initialSetup() {
        if (mapView != nil) {
            self.mapView?.removeFromSuperview()
            self.dronMissionInfoView?.removeFromSuperview()
            self.mapView = nil
            self.dronMissionInfoView = nil
        }
        self.missionInfoDTO = InjectorContainer.shared.dronServerProvider.getMissionInfoDTO()
        setupUI()
        setupMapView()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.ViewController.background
        if (missionInfoDTO != nil) {
            mapView = MKMapView(frame: CGRect.zero)
            mapView?.translatesAutoresizingMaskIntoConstraints = false
            mapView?.backgroundColor = UIColor.clear
            mapView?.delegate = self
            mapView?.mapType = MKMapType.hybrid
            self.view.addSubview(mapView!)
            
            dronInfoViewModel = DronMissionInfoViewModel(missionInfoViewModel: missionInfoDTO!)
            dronMissionInfoView = DronMissionInfoView(model: dronInfoViewModel!)
            dronInfoViewModel?.tableView = dronMissionInfoView?.tableView
            dronMissionInfoView?.translatesAutoresizingMaskIntoConstraints = false
            dronMissionInfoView?.backgroundColor = UIColor.white
            self.view.addSubview(dronMissionInfoView!)
            
            mapView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            mapView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            mapView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            mapView?.bottomAnchor.constraint(equalTo: self.dronMissionInfoView!.topAnchor, constant: 10).isActive = true
            
            dronMissionInfoView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            dronMissionInfoView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            dronMissionInfoView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            
            addPointsToMap()
        } else {
            let noMissionImageView = UIImageView(frame: CGRect.zero)
            noMissionImageView.translatesAutoresizingMaskIntoConstraints = false
            noMissionImageView.image = UIImage(named: "Screen-not mission")
            noMissionImageView.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(noMissionImageView)
            
            noMissionImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            noMissionImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            noMissionImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            noMissionImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dronInfoViewModel?.tableView?.reloadData()
    }
    
    func setupMapView() {
        if (missionInfoDTO != nil) {
            let coordinate = missionInfoDTO?.locations.last;
            mapView?.centerCoordinate = CLLocationCoordinate2D(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!)
            let regionRadius: CLLocationDistance = 5000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!), regionRadius, regionRadius)
            self.mapView?.setRegion(coordinateRegion, animated: true)
            
            var anotations = [MKAnnotation]()
            for location in (missionInfoDTO?.locations)! {
                let anotation = MKPointAnnotation()
                anotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                anotations.append(anotation)
            }
            self.mapView?.addAnnotations(anotations)
        }
    }
    
    func addPointsToMap() {
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for coordinate in (missionInfoDTO?.locations)! {
            let point = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            points.append(point)
        }
        let polyline = MKPolyline(coordinates: points, count: points.count)
        mapView?.add(polyline)
    }
    
    //MARK:- MapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.black
        polylineRenderer.lineWidth = 1
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "map-marker")
        
        return annotationView
    }
    

}


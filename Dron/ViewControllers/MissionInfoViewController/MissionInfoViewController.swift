//
//  MissionInfoViewController.swift
//  Dron
//
//  Created by Alexander on 11.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MissionInfoViewController: UIViewController, MKMapViewDelegate{
    var mapView: MKMapView?
    var dronMissionInfoView: UIView?
    var missionInfoDTO: DronMissionInfoDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.missionInfoDTO = InjectorContainer.shared.dronServerProvider.getMissionInfoDTO()
        setupUI()
    }
    
    func setupUI() {
        mapView = MKMapView(frame: CGRect.zero)
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.backgroundColor = UIColor.clear
        mapView?.delegate = self
        
        self.view.addSubview(mapView!)
        
        mapView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        mapView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        mapView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        if (missionInfoDTO != nil) {
            let coordinate = missionInfoDTO?.locations.last;
            mapView?.centerCoordinate = CLLocationCoordinate2D(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!)
            let zoomLevel = log2(360 * Double(self.view.frame.size.width) / ((mapView?.region.span.longitudeDelta)! * 128))
            let span = MKCoordinateSpanMake(0, 360 / pow(2, Double(zoomLevel)) * Double(self.view.frame.size.width) / 256)
            self.mapView?.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!), span), animated: false);

            dronMissionInfoView = DronMissionInfoView(model: missionInfoDTO)
            dronMissionInfoView?.translatesAutoresizingMaskIntoConstraints = false
            dronMissionInfoView?.backgroundColor = UIColor.white
            self.view.addSubview(dronMissionInfoView!)
            
            dronMissionInfoView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            dronMissionInfoView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            dronMissionInfoView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.size.height / 1.7).isActive = true
            dronMissionInfoView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            addPointsToMap()
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

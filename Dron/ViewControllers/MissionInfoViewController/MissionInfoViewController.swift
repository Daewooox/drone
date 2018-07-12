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

class MissionInfoViewController: UIViewController {
    var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        mapView = MKMapView(frame: CGRect.zero)
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.backgroundColor = UIColor.clear
        self.view.addSubview(mapView!)
        
        mapView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        mapView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        mapView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
}

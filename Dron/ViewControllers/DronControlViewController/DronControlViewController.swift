//
//  DronControlViewController.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class DronControlViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {
    
    let longitudeTextField: UITextField = UITextField()
    let latitudeTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.ViewController.background
        
        let sosButton: UIButton = createButton(title: "SOS")
        sosButton.addTarget(self, action: #selector(sosButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        sosButton.addTarget(self, action: #selector(buttonStartTapped(_:)), for: UIControlEvents.touchDown)
        self.view.addSubview(sosButton) // add to view as subview
        
        sosButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sosButton.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
        sosButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        sosButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        let cancelButton: UIButton = createButton(title: "Cancel")
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        cancelButton.addTarget(self, action: #selector(buttonStartTapped(_:)), for: UIControlEvents.touchDown)
        self.view.addSubview(cancelButton) // add to view as subview
        
        cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        cancelButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        /////////////
        
        longitudeTextField.tintColor = UIColor.black;
        longitudeTextField.translatesAutoresizingMaskIntoConstraints = false
        longitudeTextField.borderStyle = .roundedRect
        longitudeTextField.delegate = self
        longitudeTextField.keyboardType = .numbersAndPunctuation
        self.view.addSubview(longitudeTextField)
        
        longitudeTextField.bottomAnchor.constraint(equalTo: sosButton.topAnchor, constant: -40).isActive = true
        longitudeTextField.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 0).isActive = true
        longitudeTextField.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 0).isActive = true
        longitudeTextField.heightAnchor.constraint(equalToConstant: 44)
        
        let longitudeLabel: UILabel = UILabel()
        longitudeLabel.text = "longitude:"
        longitudeLabel.font = UIFont.systemFont(ofSize: 16)
        longitudeLabel.textColor = UIColor.black
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(longitudeLabel)
        
        longitudeLabel.bottomAnchor.constraint(equalTo: longitudeTextField.topAnchor, constant: -6).isActive = true
        longitudeLabel.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 0).isActive = true
        
        latitudeTextField.translatesAutoresizingMaskIntoConstraints = false
        latitudeTextField.borderStyle = .roundedRect
        latitudeTextField.delegate = self
        latitudeTextField.keyboardType = .numbersAndPunctuation
        self.view.addSubview(latitudeTextField)
        
        latitudeTextField.bottomAnchor.constraint(equalTo: longitudeLabel.topAnchor, constant: -12).isActive = true
        latitudeTextField.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 0).isActive = true
        latitudeTextField.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 0).isActive = true
        latitudeTextField.heightAnchor.constraint(equalToConstant: 44)
        
        let latitudeLabel: UILabel = UILabel()
        latitudeLabel.text = "latitude:"
        latitudeLabel.font = UIFont.systemFont(ofSize: 16)
        latitudeLabel.textColor = UIColor.black
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(latitudeLabel)
        
        latitudeLabel.bottomAnchor.constraint(equalTo: latitudeTextField.topAnchor, constant: -6).isActive = true
        latitudeLabel.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 0).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let legitimeSet = CharacterSet(charactersIn: "1234567890.-")
        return CharacterSet(charactersIn: string).isSubset(of: legitimeSet)
    }
    
    @objc func sosButtonTapped(_ sender: UIButton) -> Void {
        sender.backgroundColor = UIColor.DronButton.background
        sender.layer.borderColor = UIColor.DronButton.borderColor.cgColor
        InjectorContainer.shared.dronUIManager.presentUserLocationVC()
        
//        if let latitude = Double(latitudeTextField.text!), let longitude = Double(longitudeTextField.text!) {
//            InjectorContainer.shared.dronServerProvider.addSosRequest(location: CLLocationCoordinate2DMake(latitude, longitude))
//        }
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) -> Void {
        sender.backgroundColor = UIColor.DronButton.background
        sender.layer.borderColor = UIColor.DronButton.borderColor.cgColor
        InjectorContainer.shared.dronServerProvider.cancelSosRequest()
    }
    
    @objc func buttonStartTapped(_ sender: UIButton) -> Void {
        sender.backgroundColor = UIColor.DronButton.backgroundSelected
        sender.layer.borderColor = UIColor.DronButton.borderColorSelected.cgColor
    }
    
    func createButton(title: String) -> UIButton {
        let button: UIButton = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.0
        //        button.layer.borderColor = UIColor.DronButton.borderColor.cgColor
        button.backgroundColor = UIColor.DronButton.background
        return button
    }
}

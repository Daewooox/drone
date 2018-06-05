//
//  DronControlViewController.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit

class DronControlViewController: UIViewController {
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
    }
    
    @objc func sosButtonTapped(_ sender: UIButton) -> Void {
        sender.backgroundColor = UIColor.DronButton.background
        sender.layer.borderColor = UIColor.DronButton.borderColor.cgColor
        InjectorContainer.shared.dronServerProvider.addSosRequest(location: InjectorContainer.shared.dronLocationManager.getLastLocation())
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

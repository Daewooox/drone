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
import Reachability

enum DronSosButtonType: Int {
    case DronSosButtonTypeSos = 0,
    DronSosButtonTypeCancel
}

class DronControlViewController: UIViewController, MKMapViewDelegate {
    
    static let getMissionStatusInterval: Double = 10
    lazy var sosButton = UIButton(type: .custom)
    let reachability = Reachability()!
    var currentButtonState : DronSosButtonType = .DronSosButtonTypeSos
    var getMissionStatusTimer: Timer?
    
    override func viewDidLoad() {
        
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        self.view.backgroundColor = UIColor.ViewController.background
        
        sosButton = UIButton(type: .custom)
        sosButton.translatesAutoresizingMaskIntoConstraints = false
        self.updateSosButtonState(state: .DronSosButtonTypeSos)
        sosButton.addTarget(self, action: #selector(sosButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(sosButton)
        
        sosButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sosButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:0).isActive = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (InjectorContainer.shared.dronServerProvider.isDronOnTheMission()) {
            self.updateSosButtonState(state: .DronSosButtonTypeCancel)
        }
        else {
            self.updateSosButtonState(state: .DronSosButtonTypeSos)
        }
            
        if reachability.connection == .none {
            self.disableSOSbutton()
        }
        else {
            self.enableSOSbutton()
        }
        
    }
    
    func startTimer() {
        self.getMissionStatusTimer = Timer.scheduledTimer(timeInterval: DronControlViewController.getMissionStatusInterval, target: self, selector: #selector(getMissionStatus), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        self.getMissionStatusTimer?.invalidate()
    }
    
    @objc func getMissionStatus() {
        if InjectorContainer.shared.dronServerProvider.isDronOnTheMission() {
            InjectorContainer.shared.dronServerProvider.getMissionStatus { (response, error) -> (Void) in
                if error == nil {
                    let sosRequestStatusDTO = response as! DronSosRequestStatusDTO
                    if sosRequestStatusDTO.requestStatus == "completed" {
                        self.updateSosButtonState(state: .DronSosButtonTypeSos)
                        if let selectedVC = InjectorContainer.shared.dronUIManager.getSelectedVC() as? UINavigationController {
                            if let dronMissionInfoVC = selectedVC.viewControllers.first as? DronMissionInfoViewController {
                                dronMissionInfoVC.initialSetup()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
 
        switch reachability.connection {
        case .wifi:
            self.enableSOSbutton()
            break
        case .cellular:
            self.enableSOSbutton()
            break
        case .none:
            self.disableSOSbutton()
        }
    }
    
    
    func disableSOSbutton() -> Void {
        sosButton.isEnabled = false
    }
    
    
    func enableSOSbutton() -> Void {
        sosButton.isEnabled = true
    }
    
    
    func updateSosButtonState(state: DronSosButtonType) -> Void {
        switch state {
        case .DronSosButtonTypeSos:
            sosButton.setImage(UIImage(named: "Button-SOS-enabled"), for: .normal)
            sosButton.setImage(UIImage(named: "Button-SOS-pressed"), for: .highlighted)
            sosButton.setImage(UIImage(named: "Button-SOS-pressed"), for: .selected)
            sosButton.setImage(UIImage(named: "Button-SOS-disabled"), for: .disabled)
            self.enableSOSbutton()
            self.stopTimer()
            break
        case .DronSosButtonTypeCancel:
            sosButton.setImage(UIImage(named: "Button-CANCEL-enabled"), for: .normal)
            sosButton.setImage(UIImage(named: "Button-CANCEL-pressed"), for: .highlighted)
            sosButton.setImage(UIImage(named: "Button-CANCEL-pressed"), for: .selected)
            sosButton.setImage(UIImage(named: "Button-CANCEL-disabled"), for: .disabled)
            self.enableSOSbutton()
            break
        }
        currentButtonState = state
    }
    
    
    @objc func sosButtonTapped(_ sender: UIButton) -> Void {
        if currentButtonState == .DronSosButtonTypeSos {
            InjectorContainer.shared.dronUIManager.presentUserLocationVC()
        }
        else {
            InjectorContainer.shared.dronServerProvider.cancelSosRequest { (status, error) -> (Void) in
                if error == nil {
                    self.updateSosButtonState(state: .DronSosButtonTypeSos)
                }
                else {
                    
                }
            }
        }
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

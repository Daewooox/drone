//
//  DronAccountViewController.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

import UIKit

class DronAccountViewController: UIViewController {
    
    let dronAccountViewModel = DronAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    
    internal func setupUI() {
        self.view.backgroundColor = UIColor.ViewController.background
        
        let dronAccountView : DronAccountView = DronAccountView(model: dronAccountViewModel)
        dronAccountViewModel.tableView = dronAccountView.tableView
        
        dronAccountView.translatesAutoresizingMaskIntoConstraints = false
        dronAccountView.backgroundColor = UIColor.clear
        
        self.view.addSubview(dronAccountView)
        
        dronAccountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        dronAccountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        dronAccountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        dronAccountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        let editButton = UIButton(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        editButton.setTitle(NSLocalizedString("Done", comment: "Done"), for: UIControlState.normal)
        editButton.addTarget(self, action: #selector(onDoneBtnTap), for: UIControlEvents.touchUpInside)
        
        let editBatItem = UIBarButtonItem(customView: editButton)
        self.navigationItem.rightBarButtonItem = editBatItem;
    }
    
    @objc func onDoneBtnTap() -> Void {
        InjectorContainer.shared.dronKeychainManager.registerNewUser(account: dronAccountViewModel.getUpdatedAccount())
    }
}

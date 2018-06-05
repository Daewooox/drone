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
    var editButton : UIButton?
    var isEditingMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         view.endEditing(true)
        setUsualMode()
    }
    
    
    internal func setupUI() {
        self.view.backgroundColor = UIColor.ViewController.background
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let dronAccountView : DronAccountView = DronAccountView(model: dronAccountViewModel)
        dronAccountViewModel.tableView = dronAccountView.tableView
        
        dronAccountView.translatesAutoresizingMaskIntoConstraints = false
        dronAccountView.backgroundColor = UIColor.clear
        
        self.view.addSubview(dronAccountView)
        
        dronAccountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        dronAccountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        dronAccountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        dronAccountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        editButton = UIButton(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        editButton?.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: UIControlState.normal)
        editButton?.addTarget(self, action: #selector(onDoneBtnTap), for: UIControlEvents.touchUpInside)
        
        let editBatItem = UIBarButtonItem(customView: editButton!)
        
        self.navigationItem.rightBarButtonItem = editBatItem;
        
        dronAccountViewModel.tableView?.isUserInteractionEnabled = false
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func onDoneBtnTap() -> Void {
        
        if isEditingMode == true {
            InjectorContainer.shared.dronServerProvider.updateAccount(accountDTO: dronAccountViewModel.getUpdatedAccount()) { (responce, error) -> (Void) in
                InjectorContainer.shared.dronKeychainManager.registerNewUser(account: dronAccountViewModel.getUpdatedAccount())
            }
        }
        
        if isEditingMode == true {
            setUsualMode()
        }
        else {
            setEditingMode()
        }
    }
    
    func setEditingMode() -> Void {
        editButton?.setTitle(NSLocalizedString("Done", comment: "Done"), for: UIControlState.normal)
        dronAccountViewModel.tableView?.isUserInteractionEnabled = true
        let editBatItem = UIBarButtonItem(customView: editButton!)
        self.navigationItem.rightBarButtonItem = editBatItem;
        isEditingMode = isEditingMode == true ? false : true
    }
    
    func setUsualMode() -> Void {
        editButton?.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: UIControlState.normal)
        dronAccountViewModel.tableView?.isUserInteractionEnabled = false
        let editBatItem = UIBarButtonItem(customView: editButton!)
        self.navigationItem.rightBarButtonItem = editBatItem;
        isEditingMode = isEditingMode == true ? false : true
    }
}

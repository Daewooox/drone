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
    
    var dronAccountViewModel : DronAccountViewModel?
    var editButton : UIButton?
    var cancelButton : UIButton?
    var isEditingMode: Bool = false
    
    override func viewDidLoad() {
        dronAccountViewModel = DronAccountViewModel(model: InjectorContainer.shared.dronKeychainManager.getCurrentUser()!)
        super.viewDidLoad()
        setupUI();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(with:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(with:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        
        let dronAccountView : DronAccountView = DronAccountView(model: dronAccountViewModel!)
        dronAccountViewModel?.tableView = dronAccountView.tableView
        
        dronAccountView.translatesAutoresizingMaskIntoConstraints = false
        dronAccountView.backgroundColor = UIColor.clear
        
        self.view.addSubview(dronAccountView)
        
        dronAccountViewModel?.subscribeToNotifications()
        
        dronAccountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        dronAccountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        dronAccountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        dronAccountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        editButton = UIButton(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        
        editButton?.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: UIControlState.normal)
        editButton?.addTarget(self, action: #selector(onDoneBtnTap), for: UIControlEvents.touchUpInside)
        editButton?.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        let editBatItem = UIBarButtonItem(customView: editButton!)
        
        
        cancelButton = UIButton(frame: CGRect(x: 0, y: 7, width: 20, height: 20))
        
        cancelButton?.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: UIControlState.normal)
        cancelButton?.addTarget(self, action: #selector(onCancelBtnTap), for: UIControlEvents.touchUpInside)
        cancelButton?.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        let cancelBatItem = UIBarButtonItem(customView: cancelButton!)
        
        self.navigationItem.rightBarButtonItem = editBatItem;
        
        self.navigationItem.leftBarButtonItem = cancelBatItem;
        cancelButton?.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        cancelButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    
    @objc func keyboardDidShow(with notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        dronAccountViewModel?.tableView?.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
    }
    
    
    @objc func keyboardWillHide(with notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        dronAccountViewModel?.tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func onCancelBtnTap() -> Void {
        self.setUsualMode()
        dronAccountViewModel?.accountDTO = InjectorContainer.shared.dronKeychainManager.getCurrentUser()!
        dronAccountViewModel?.tableView?.reloadData()
    }
    
    
    @objc func onDoneBtnTap() -> Void {
        
        if isEditingMode == true {
            let accountDTO : DronAccount? = dronAccountViewModel?.getUpdatedAccount()!
            if accountDTO != nil {
                InjectorContainer.shared.dronServerProvider.updateAccount(accountDTO: accountDTO!) { (responce, error) -> (Void) in
                    InjectorContainer.shared.dronKeychainManager.registerNewUser(account: accountDTO!)
                    dronAccountViewModel?.accountDTO = accountDTO
                }
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

        let editBatItem = UIBarButtonItem(customView: editButton!)
        self.navigationItem.rightBarButtonItem = editBatItem;
        isEditingMode = isEditingMode == true ? false : true
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DronAccountViewModelModeNotificationName), object: nil, userInfo: ["enable": isEditingMode])
        
        self.dronAccountViewModel?.tableView?.reloadData()
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true;
    }
    
    func setUsualMode() -> Void {
        editButton?.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: UIControlState.normal)
        
        let editBatItem = UIBarButtonItem(customView: editButton!)
        self.navigationItem.rightBarButtonItem = editBatItem;
        isEditingMode = false
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DronAccountViewModelModeNotificationName), object: nil, userInfo: ["enable": isEditingMode])
        
        self.dronAccountViewModel?.tableView?.reloadData()
        self.navigationItem.leftBarButtonItem?.isEnabled = false;
    }
}

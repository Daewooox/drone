//
//  DronMissionHistoryViewController.swift
//  Dron
//
//  Created by Alexander on 24.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionHistoryViewController: UIViewController {
    
    var accountMissions: [DronMissionInfoDTO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let accountMissionsModel = DronMissionHistoryViewModel(missionInfoModel: InjectorContainer.shared.dronServerProvider.getAccountMissionsDTO())
        let accountMissionsView = DronMissionHistoryView(model: accountMissionsModel)
        accountMissionsModel.tableView = accountMissionsView.tableView
        accountMissionsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.ViewController.background
        self.view.addSubview(accountMissionsView)
        
        accountMissionsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        accountMissionsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        accountMissionsView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        accountMissionsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }

}

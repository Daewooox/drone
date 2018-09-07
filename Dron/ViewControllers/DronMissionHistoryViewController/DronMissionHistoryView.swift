//
//  DronMissionHistoryView.swift
//  Dron
//
//  Created by Alexander on 28.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionHistoryView: UIView {
    
    var tableView: UITableView
    var dronHistoryViewModel: DronMissionHistoryViewModel
    
    init(model: DronMissionHistoryViewModel) {
        self.tableView = UITableView(frame: CGRect.zero)
        self.dronHistoryViewModel = model
        super.init(frame: CGRect.zero)
        self.tableView.dataSource = model
        self.tableView.delegate = model
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 36
        self.tableView.register(DronMissionHistoryTableViewCell.self, forCellReuseIdentifier: String.init(describing: DronMissionHistoryTableViewCell.self))
        self.addSubview(self.tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }

}

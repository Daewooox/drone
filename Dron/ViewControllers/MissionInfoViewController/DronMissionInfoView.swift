//
//  DronMissionInfoView.swift
//  Dron
//
//  Created by Alexander on 12.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionInfoView: UIView {
    
    var tableView : UITableView

    init(model: DronMissionInfoViewModel) {
        self.tableView = UITableView(frame: CGRect.zero)
        super.init(frame: CGRect.zero)
        self.tableView.dataSource = model
        self.tableView.delegate = model
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCornersWithBorder([.topLeft, .topRight], [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 15)
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.white

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isUserInteractionEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 25
        tableView.register(DronMissionInfoTableViewCell.self, forCellReuseIdentifier: String.init(describing: DronMissionInfoTableViewCell.self))
        self.addSubview(tableView)
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()

        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
    }
    
}



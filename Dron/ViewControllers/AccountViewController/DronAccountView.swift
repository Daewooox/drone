//
//  DronAccountView.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronAccountView: UIView {
    var tableView : UITableView
    var tableViewModel : DronAccountViewModel
    
    init(model: DronAccountViewModel) {
        self.tableViewModel = model
        self.tableView = UITableView(frame: CGRect.zero)
        self.tableView.dataSource = model
        super.init(frame: CGRect.zero)
        self.tableView.delegate = self
        
        self.setupUI()
    }
    
//    override init(frame: CGRect) {
//        setupUI()
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    internal func setupUI() -> Void {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        
        tableView.register(DronAccountTableViewCell.self, forCellReuseIdentifier: String.init(describing: DronAccountTableViewCell.self))
        self.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}


extension DronAccountView : UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
}

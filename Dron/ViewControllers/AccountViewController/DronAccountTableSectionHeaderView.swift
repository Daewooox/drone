//
//  DronAccountTableSectionHeaderView.swift
//  Dron
//
//  Created by Dmtech on 10.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronAccountTableSectionHeaderView: UITableViewHeaderFooterView {
    var titleLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    internal func setupUI() {
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.backgroundView?.backgroundColor = UIColor.clear
        self.backgroundView?.tintColor = UIColor.clear
        
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor.clear
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = UIColor.black
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        } else {
            titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        }
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
    }
}

//
//  DronMissionInfoTableViewCell.swift
//  Dron
//
//  Created by Alexander on 17.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionInfoTableViewCell: UITableViewCell {

    var infoLabel : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    internal func setupUI() {
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.textColor = UIColor.black
        self.infoLabel.font = UIFont.systemFont(ofSize: 18)
        self.infoLabel.numberOfLines = 0
        self.infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentView.addSubview(self.infoLabel)
        
        self.infoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        self.infoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.infoLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        self.infoLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
    }
    

}

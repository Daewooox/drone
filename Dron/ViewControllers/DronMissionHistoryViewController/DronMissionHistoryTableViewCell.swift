//
//  DronMissionHistoryTableViewCell.swift
//  Dron
//
//  Created by Alexander on 28.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionHistoryTableViewCell: UITableViewCell {
    
    var missionIdView = UIView(frame: CGRect.zero)
    var droneIdView = UIView(frame: CGRect.zero)
    var createdAtView = UIView(frame: CGRect.zero)
    var statusView = UIView(frame: CGRect.zero)
    
    var missionIdLabel = UILabel(frame: CGRect.zero)
    var droneIdLabel = UILabel(frame: CGRect.zero)
    var createdAtLabel = UILabel(frame: CGRect.zero)
    var statusLabel = UILabel(frame: CGRect.zero)
    
    var leadingIndent: CGFloat = 15
    var trailingIndent: CGFloat = 15
    var leadingIndentDroneIdView: CGFloat = 20
    var leadingIndentCreatedAtIdView: CGFloat = 20
    var leadingIndentStatusIdView: CGFloat = 30
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        self.contentView.backgroundColor = UIColor.ViewController.background
        if DeviceType.IS_IPHONE_5 {
            self.leadingIndent = 10
            self.trailingIndent = 10
            self.leadingIndentDroneIdView = 15
            self.leadingIndentCreatedAtIdView = 15
            self.leadingIndentStatusIdView = 15
        }
        let viewWidth = UIScreen.main.bounds.width - leadingIndent - trailingIndent - leadingIndentDroneIdView - leadingIndentCreatedAtIdView - leadingIndentStatusIdView
        missionIdView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(missionIdView)
        missionIdView.widthAnchor.constraint(equalToConstant: viewWidth * 0.25).isActive = true
        missionIdView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leadingIndent).isActive = true
        missionIdView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        missionIdView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        droneIdView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(droneIdView)
        droneIdView.widthAnchor.constraint(equalToConstant: viewWidth * 0.20).isActive = true
        droneIdView.leadingAnchor.constraint(equalTo: self.missionIdView.trailingAnchor, constant: leadingIndentDroneIdView).isActive = true
        droneIdView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        droneIdView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        createdAtView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(createdAtView)
        createdAtView.widthAnchor.constraint(equalToConstant: viewWidth * 0.35).isActive = true
        createdAtView.leadingAnchor.constraint(equalTo: self.droneIdView.trailingAnchor, constant: leadingIndentCreatedAtIdView).isActive = true
        createdAtView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        createdAtView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(statusView)
        statusView.widthAnchor.constraint(equalToConstant: viewWidth * 0.25).isActive = true
        statusView.leadingAnchor.constraint(equalTo: self.createdAtView.trailingAnchor, constant: leadingIndentStatusIdView).isActive = true
        statusView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        let sfRegularFont = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        missionIdLabel.translatesAutoresizingMaskIntoConstraints = false
        missionIdLabel.font = sfRegularFont
        missionIdView.addSubview(missionIdLabel)
        
        droneIdLabel.translatesAutoresizingMaskIntoConstraints = false
        droneIdLabel.font = sfRegularFont
        droneIdView.addSubview(droneIdLabel)
        
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.font = UIFont.italicSystemFont(ofSize: 10.0)
        createdAtLabel.numberOfLines = 0
        createdAtLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        createdAtView.addSubview(createdAtLabel)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = sfRegularFont
        statusView.addSubview(statusLabel)
    }
    
    func setupConstraints() {
        missionIdLabel.leadingAnchor.constraint(equalTo: self.missionIdView.leadingAnchor, constant: 0).isActive = true
        missionIdLabel.trailingAnchor.constraint(equalTo: self.missionIdView.trailingAnchor, constant: 0).isActive = true
        missionIdLabel.centerYAnchor.constraint(equalTo: self.missionIdView.centerYAnchor).isActive = true

        droneIdLabel.leadingAnchor.constraint(equalTo: self.droneIdView.leadingAnchor, constant: 0).isActive = true
        droneIdLabel.centerYAnchor.constraint(equalTo: self.droneIdView.centerYAnchor).isActive = true
        droneIdLabel.trailingAnchor.constraint(equalTo: self.droneIdView.trailingAnchor, constant: 0).isActive = true

        createdAtLabel.leadingAnchor.constraint(equalTo: self.createdAtView.leadingAnchor, constant: 0).isActive = true
        createdAtLabel.centerYAnchor.constraint(equalTo: self.createdAtView.centerYAnchor).isActive = true
        createdAtLabel.trailingAnchor.constraint(equalTo: self.createdAtView.trailingAnchor, constant: 0).isActive = true

        statusLabel.leadingAnchor.constraint(equalTo: self.statusView.leadingAnchor, constant: 0).isActive = true
        statusLabel.centerYAnchor.constraint(equalTo: self.statusView.centerYAnchor).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: self.statusView.trailingAnchor, constant: 0).isActive = true
    }

}

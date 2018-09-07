//
//  DronMissionHistoryTableHeaderView.swift
//  Dron
//
//  Created by Alexander on 30.08.2018.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionHistoryTableHeaderView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.HeaderView.background
        var sfBoldFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        if DeviceType.IS_IPHONE_5 {
            self.leadingIndent = 10
            self.trailingIndent = 10
            self.leadingIndentDroneIdView = 15
            self.leadingIndentCreatedAtIdView = 15
            self.leadingIndentStatusIdView = 15
            sfBoldFont = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.bold)
        }
        let viewWidth = UIScreen.main.bounds.width - leadingIndent - trailingIndent - leadingIndentDroneIdView - leadingIndentCreatedAtIdView - leadingIndentStatusIdView
        missionIdView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(missionIdView)
        missionIdView.widthAnchor.constraint(equalToConstant: viewWidth * 0.25).isActive = true
        missionIdView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingIndent).isActive = true
        missionIdView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        missionIdView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        droneIdView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(droneIdView)
        droneIdView.widthAnchor.constraint(equalToConstant: viewWidth * 0.20).isActive = true
        droneIdView.leadingAnchor.constraint(equalTo: self.missionIdView.trailingAnchor, constant: leadingIndentDroneIdView).isActive = true
        droneIdView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        droneIdView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        createdAtView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createdAtView)
        createdAtView.widthAnchor.constraint(equalToConstant: viewWidth * 0.35).isActive = true
        createdAtView.leadingAnchor.constraint(equalTo: self.droneIdView.trailingAnchor, constant: leadingIndentCreatedAtIdView).isActive = true
        createdAtView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        createdAtView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statusView)
        statusView.widthAnchor.constraint(equalToConstant: viewWidth * 0.25).isActive = true
        statusView.leadingAnchor.constraint(equalTo: self.createdAtView.trailingAnchor, constant: leadingIndentStatusIdView).isActive = true
        statusView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        missionIdLabel.translatesAutoresizingMaskIntoConstraints = false
        missionIdLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        missionIdView.addSubview(missionIdLabel)
        
        droneIdLabel.translatesAutoresizingMaskIntoConstraints = false
        droneIdLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        droneIdView.addSubview(droneIdLabel)
        
        missionIdLabel.translatesAutoresizingMaskIntoConstraints = false
        missionIdLabel.font = sfBoldFont
        missionIdLabel.text = NSLocalizedString("Mission ID", comment: "Mission ID")
        missionIdView.addSubview(missionIdLabel)
        
        droneIdLabel.translatesAutoresizingMaskIntoConstraints = false
        droneIdLabel.font = sfBoldFont
        droneIdLabel.text = NSLocalizedString("Drone ID", comment: "Drone ID")
        droneIdView.addSubview(droneIdLabel)
        
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.font = sfBoldFont
        createdAtLabel.text = NSLocalizedString("Creation date", comment: "Creation date")
        createdAtView.addSubview(createdAtLabel)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = sfBoldFont
        statusLabel.text = NSLocalizedString("Status", comment: "Status")
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

//
//  DronMissionInfoView.swift
//  Dron
//
//  Created by Alexander on 12.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

class DronMissionInfoView: UIView {
    
    var idLabel : UILabel = UILabel()
    var accountIdLabel : UILabel = UILabel()
    var droneIdLabel : UILabel = UILabel()
    var statusLabel : UILabel = UILabel()
    var createdAtLabel : UILabel = UILabel()
    
    lazy var stack: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        stackView.addArrangedSubview(self.idLabel)
        stackView.addArrangedSubview(self.accountIdLabel)
        stackView.addArrangedSubview(self.droneIdLabel)
        stackView.addArrangedSubview(self.statusLabel)
        stackView.addArrangedSubview(self.createdAtLabel)
        
        return stackView
    }()
    
    var missionInfoViewModel : DronMissionInfoDTO?
    
    init(model: DronMissionInfoDTO?) {
        self.missionInfoViewModel = model
        super.init(frame: CGRect.zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor.white
        self.addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        
    }

}



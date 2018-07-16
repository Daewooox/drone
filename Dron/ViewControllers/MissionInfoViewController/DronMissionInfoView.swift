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
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.white
        
        stackView.addArrangedSubview(self.idLabel)
        stackView.addArrangedSubview(self.accountIdLabel)
        stackView.addArrangedSubview(self.droneIdLabel)
        stackView.addArrangedSubview(self.statusLabel)
        stackView.addArrangedSubview(self.createdAtLabel)
        return stackView
    }()
    
    var missionInfoViewModel : DronMissionInfoDTO?
    
    init(model: DronMissionInfoDTO?) {
        super.init(frame: CGRect.zero)
        self.missionInfoViewModel = model
        
        self.setupUI()
        self.setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 25).isActive = true
        
    }
    
    func setupLabels() {
        self.idLabel.attributedText = self.formatedText(normalText: "\(String(describing: self.missionInfoViewModel!.id))", boldText: NSLocalizedString("Last mission id: ", comment: "Last mission id: "))
        self.accountIdLabel.attributedText = self.formatedText(normalText: "\(String(describing: self.missionInfoViewModel!.accountId))", boldText: NSLocalizedString("Account id: ", comment: "Account id: "))
        self.droneIdLabel.attributedText = self.formatedText(normalText: "\(String(describing: self.missionInfoViewModel!.droneId))", boldText: NSLocalizedString("Drone id: ", comment: "Drone id: "))
        self.statusLabel.attributedText = self.formatedText(normalText: (self.missionInfoViewModel!.status), boldText: NSLocalizedString("Status: ", comment: "Status: "))
        self.createdAtLabel.attributedText = self.formatedText(normalText: "\(Date(timeIntervalSince1970: Double(self.missionInfoViewModel!.date)))", boldText: NSLocalizedString("Created at: ", comment: "Created at: "))
    }
    
    func formatedText(normalText: String, boldText: String) -> NSMutableAttributedString {
        let boldAttrs: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)]
        let normAttrs: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)]
        let normalAttText = NSMutableAttributedString(string: normalText, attributes: normAttrs)
        let boldAttText = NSMutableAttributedString(string: boldText, attributes: boldAttrs)
        boldAttText.append(normalAttText)
        return boldAttText
    }

}

//
//  DronMissionInfoViewModel.swift
//  Dron
//
//  Created by Alexander on 17.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

enum DronMissionInfoViewModelRowType: Int {
    case DronMissionInfoViewModelId = 0,
    DronMissionInfoViewModelAccountId,
    DronMissionInfoViewModelDroneId,
    DronMissionInfoViewModelStatus,
    DronMissionInfoViewModelCreatedAt
}

class DronMissionInfoViewModel: NSObject {

    var rowsModel = [NSMutableAttributedString]()
    
    init(missionInfoViewModel: DronMissionInfoDTO) {
        super.init()
        rowsModel.append(self.formatedText(normalText: "\(String(describing: missionInfoViewModel.id))", boldText: NSLocalizedString("Last mission id: ", comment: "Last mission id: ")))
        rowsModel.append(self.formatedText(normalText: "\(String(describing: missionInfoViewModel.accountId))", boldText: NSLocalizedString("Account id: ", comment: "Account id: ")))
        rowsModel.append(self.formatedText(normalText: "\(String(describing: missionInfoViewModel.droneId))", boldText: NSLocalizedString("Drone id: ", comment: "Drone id: ")))
        rowsModel.append(self.formatedText(normalText: missionInfoViewModel.status, boldText: NSLocalizedString("Status: ", comment: "Status: ")))
        
        let date = Date(timeIntervalSince1970: Double(missionInfoViewModel.date)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.ReferenceType.default
        let localDate = dateFormatter.string(from: date)
        rowsModel.append(self.formatedText(normalText: localDate, boldText: NSLocalizedString("Created at: ", comment: "Created at: ")))
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

extension DronMissionInfoViewModel : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DronMissionInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DronMissionInfoTableViewCell.self), for: indexPath) as! DronMissionInfoTableViewCell
        cell.infoLabel.attributedText = self.rowsModel[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

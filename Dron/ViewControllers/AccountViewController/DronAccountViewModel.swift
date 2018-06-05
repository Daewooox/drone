//
//  DronAccountViewModel.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

enum DronAccountViewModelRowType: Int {
    case DronAccountViewModelContanctInfo = 0,
    DronAccountViewMedicalData,
    DronAccountViewEmergencyContactInformation,
    DronAccountViewModelRowsNumber
}

struct DronAccountViewModelRowModel {
    let rowType : DronAccountViewModelRowType
    let rowTitle : String
    
}


class DronAccountViewModel : NSObject {
    
    weak var tableView : UITableView?
    
    var rowsModel : [DronAccountViewModelRowModel] = [
        DronAccountViewModelRowModel(rowType: .DronAccountViewModelContanctInfo, rowTitle: NSLocalizedString("Contact info:", comment: "Contact info:")),
        DronAccountViewModelRowModel(rowType: .DronAccountViewMedicalData, rowTitle: NSLocalizedString("Medical data:", comment: "Medical data:")),
        DronAccountViewModelRowModel(rowType: .DronAccountViewEmergencyContactInformation, rowTitle: NSLocalizedString("Emergency contact info:", comment: "Emergency contact info:"))
    ]
}

extension DronAccountViewModel : UITableViewDataSource {
    
    func getUpdatedAccount() -> DronAccount {
        var accountDTO = InjectorContainer.shared.dronKeychainManager.getCurrentUser()
        let contactcell : DronAccountTableViewCell = tableView?.cellForRow(at: IndexPath(item: DronAccountViewModelRowType.DronAccountViewModelContanctInfo.rawValue, section: 0)) as! DronAccountTableViewCell
        let contactInfo = contactcell.textView.text
        
        let medicalcell : DronAccountTableViewCell = tableView?.cellForRow(at: IndexPath(item: DronAccountViewModelRowType.DronAccountViewMedicalData.rawValue, section: 0)) as! DronAccountTableViewCell
        let medicalInfo = medicalcell.textView.text
        
        let emergencycell : DronAccountTableViewCell = tableView?.cellForRow(at: IndexPath(item: DronAccountViewModelRowType.DronAccountViewEmergencyContactInformation.rawValue, section: 0)) as! DronAccountTableViewCell
        let emergencyInfo = emergencycell.textView.text
        
        accountDTO?.contactInformation = contactInfo ?? ""
        accountDTO?.medicalData = medicalInfo ?? ""
        accountDTO?.emergencyContactInformation = emergencyInfo ?? ""
        return accountDTO!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DronAccountTableViewCell  = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DronAccountTableViewCell.self), for: indexPath) as! DronAccountTableViewCell
        let rowModel : DronAccountViewModelRowModel = self.rowsModel[indexPath.row]
        
        var textValue : String = ""
        let accountDTO = InjectorContainer.shared.dronKeychainManager.getCurrentUser()
        
        switch rowModel.rowType {
        case .DronAccountViewModelContanctInfo: textValue = accountDTO?.contactInformation ?? "" ; break
        case .DronAccountViewMedicalData: textValue = accountDTO?.medicalData ?? ""; break
        case .DronAccountViewEmergencyContactInformation: textValue = accountDTO?.emergencyContactInformation ?? ""; break
        default: break
        }
        
        cell.titleLabel.text = rowModel.rowTitle
        cell.textView.text = textValue
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

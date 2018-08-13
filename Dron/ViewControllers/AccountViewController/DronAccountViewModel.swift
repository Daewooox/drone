//
//  DronAccountViewModel.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum DronAccountViewModelSectionType: Int {
    case DronAccountViewModelSectionTypeInfo = 0,
    DronAccountViewModelSectionTypeEmergency,
    DronAccountViewModelSectionTypeMedical,
    DronAccountViewModelSectionTypeNumber
}

enum DronAccountViewModelSectionInfoRowType: Int {
    case DronAccountViewModelSectionInfoRowTypeAddress = 0,
    DronAccountViewModelSectionInfoRowTypeName,
    DronAccountViewModelSectionInfoRowTypePhone,
    DronAccountViewModelSectionInfoRowNumber
}

enum DronAccountViewModelSectionEmergencyRowType: Int {
    case DronAccountViewModelSectionEmergencyRowTypeContactPerson = 0,
    DronAccountViewModelSectionEmergencyRowTypeContactNumber,
    DronAccountViewModelSectionEmergencyRowTypeContactEmail,
    DronAccountViewModelSectionEmergencyRowNumber
}


enum DronAccountViewModelSectionMedicalInformationRowType: Int {
    case DronAccountViewModelSectionMedicalInformationRowTypeBloodType = 0,
    DronAccountViewModelSectionMedicalInformationRowTypeMedicalConditions,
    DronAccountViewModelSectionMedicalInformationRowTypePrescription,
    DronAccountViewModelSectionMedicalInformationRowTypePrescriptionAllergies,
    DronAccountViewModelSectionMedicalInformationRowTypeNumber
}

struct DronAccountViewModelSectionModel {
    let rowsModel : [DronAccountViewModelRowModel]
    let sectionTitle : String
}

struct DronAccountViewModelRowModel {
    let rowType : Int
    let rowTitle : String
}


class DronAccountViewModel : NSObject {
    weak var tableView : UITableView?
    var accountDTO : DronAccount?
    
    init(model: DronAccount) {
        self.accountDTO = model
    }
    
    var rowsInfoModels : [DronAccountViewModelRowModel] = [
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeAddress.rawValue, rowTitle: NSLocalizedString("Address:", comment: "Address:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeName.rawValue, rowTitle: NSLocalizedString("Username:", comment: "Username:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypePhone.rawValue, rowTitle: NSLocalizedString("Phone:", comment: "Phone:"))
    ]
    
    var rowsEmergencyModel : [DronAccountViewModelRowModel] = [
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactPerson.rawValue, rowTitle: NSLocalizedString("Emergency contact person:", comment: "Emergency contact person:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactNumber.rawValue, rowTitle: NSLocalizedString("Emergency contact number:", comment: "Emergency contact number:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactEmail.rawValue, rowTitle: NSLocalizedString("Emergency contact email:", comment: "Emergency contact email:"))
    ]
    
    var rowsMedicalInfoModel : [DronAccountViewModelRowModel] = [
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeBloodType.rawValue, rowTitle: NSLocalizedString("Blood type:", comment: "Blood type:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeMedicalConditions.rawValue, rowTitle: NSLocalizedString("Known medical conditions:", comment: "Known medical conditions:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescription.rawValue, rowTitle: NSLocalizedString("Known prescription medications being taken:", comment: "Known prescription medications being taken:")),
        DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescriptionAllergies.rawValue, rowTitle: NSLocalizedString("Known allergies:", comment: "Known allergies:"))
    ]

    var sectionsData : [DronAccountViewModelSectionModel] = [
        DronAccountViewModelSectionModel(rowsModel: [
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeAddress.rawValue, rowTitle: NSLocalizedString("Address:", comment: "Address:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeName.rawValue, rowTitle: NSLocalizedString("Name:", comment: "Name:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypePhone.rawValue, rowTitle: NSLocalizedString("Phone:", comment: "Phone:"))
            ], sectionTitle: NSLocalizedString("Info:", comment: "Info:")),
        DronAccountViewModelSectionModel(rowsModel: [
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactPerson.rawValue, rowTitle: NSLocalizedString("Emergency contact person:", comment: "Emergency contact person:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactNumber.rawValue, rowTitle: NSLocalizedString("Emergency contact number:", comment: "Emergency contact number:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactEmail.rawValue, rowTitle: NSLocalizedString("Emergency contact email:", comment: "Emergency contact email:"))
            ], sectionTitle: NSLocalizedString("Emergency info:", comment: "Emergency info:")),
        DronAccountViewModelSectionModel(rowsModel: [
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeBloodType.rawValue, rowTitle: NSLocalizedString("Blood type:", comment: "Blood type:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeMedicalConditions.rawValue, rowTitle: NSLocalizedString("Known medical conditions:", comment: "Known medical conditions:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescription.rawValue, rowTitle: NSLocalizedString("Known prescription medications being taken:", comment: "Known prescription medications being taken:")),
            DronAccountViewModelRowModel(rowType: DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescriptionAllergies.rawValue, rowTitle: NSLocalizedString("Known allergies:", comment: "Known allergies:"))
            ], sectionTitle: NSLocalizedString("Medical info:", comment: "Medical info:"))
    ]
}

extension DronAccountViewModel : UITableViewDataSource {
    
    
    func getUpdatedAccount() -> DronAccount? {
        return accountDTO!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].rowsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DronAccountTableViewCell  = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DronAccountTableViewCell.self), for: indexPath) as! DronAccountTableViewCell
        let rowModel : DronAccountViewModelRowModel = sectionsData[indexPath.section].rowsModel[indexPath.row]
        
        var textValue : String = ""
        
        let disposeBag = DisposeBag()
        
        switch indexPath.section {
            
        case DronAccountViewModelSectionType.DronAccountViewModelSectionTypeInfo.rawValue:
            switch indexPath.row {
            case DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeAddress.rawValue:
                textValue = accountDTO?.address ?? ""
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.address = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypeName.rawValue:
                textValue = accountDTO?.name ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.name = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionInfoRowType.DronAccountViewModelSectionInfoRowTypePhone.rawValue:
                textValue = accountDTO?.phoneNumber ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.phoneNumber = cell.textView.text!
                })
                break
            default: break
            }
            break;
        case DronAccountViewModelSectionType.DronAccountViewModelSectionTypeEmergency.rawValue:
            switch indexPath.row {
            case DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactNumber.rawValue:
                textValue = accountDTO?.emergencyContactNumber ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.emergencyContactNumber = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactEmail.rawValue:
                textValue = accountDTO?.emergencyContactEmail ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.emergencyContactEmail = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionEmergencyRowType.DronAccountViewModelSectionEmergencyRowTypeContactPerson.rawValue:
                textValue = accountDTO?.emergencyContactPerson ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.emergencyContactPerson = cell.textView.text!
                })
                break
            default : break
            }
            break
        case DronAccountViewModelSectionType.DronAccountViewModelSectionTypeMedical.rawValue:
            switch indexPath.row {
            case DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeBloodType.rawValue:
                textValue = accountDTO?.bloodType ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.bloodType = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypeMedicalConditions.rawValue:
                textValue = accountDTO?.knownMedicalConditions ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.knownMedicalConditions = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescriptionAllergies.rawValue:
                textValue = accountDTO?.knownAllergies ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.knownAllergies = cell.textView.text!
                })
                break
            case DronAccountViewModelSectionMedicalInformationRowType.DronAccountViewModelSectionMedicalInformationRowTypePrescription.rawValue:
                textValue = accountDTO?.knownPrescriptionMedicationsBeingTaken ?? "" ;
                cell.textView.rx.text.subscribe({_ in
                    self.accountDTO?.knownPrescriptionMedicationsBeingTaken = cell.textView.text!
                })
                break
            default : break
            }
        default: break
        }
        cell.titleLabel.text = rowModel.rowTitle
        cell.textView.text = textValue
        cell.textViewText = textValue
        return cell
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return DronAccountViewModelSectionType.DronAccountViewModelSectionTypeNumber.rawValue
    }
}

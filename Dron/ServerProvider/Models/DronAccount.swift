//
//  DronAccount.swift
//  Dron
//
//  Created by Dmtech on 22.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit
import RxSwift

struct DronAccount {
    var deviceId: String = ""
    var address : String = ""
    var name: String = ""
    var phoneNumber: String = ""
    
    var emergencyContactPerson: String = ""
    var emergencyContactNumber: String = ""
    var emergencyContactEmail: String = ""
    
    var bloodType: String = ""
    var knownMedicalConditions: String = ""
    var knownPrescriptionMedicationsBeingTaken: String = ""
    var knownAllergies: String = ""

    enum CodingKeys : String, CodingKey {
        case deviceId
        case address
        case name
        case phoneNumber
        case emergencyContactPerson
        case emergencyContactNumber
        case emergencyContactEmail
        case bloodType
        case knownMedicalConditions
        case knownPrescriptionMedicationsBeingTaken
        case knownAllergies
    }
}


extension DronAccount: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        deviceId = try values.decode(String.self, forKey: .deviceId)
        address = try values.decode(String.self, forKey: .address)
        name = try values.decode(String.self, forKey: .name)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        emergencyContactPerson = try values.decode(String.self, forKey: .emergencyContactPerson)
        emergencyContactNumber = try values.decode(String.self, forKey: .emergencyContactNumber)
        emergencyContactEmail = try values.decode(String.self, forKey: .emergencyContactEmail)
        bloodType = try values.decode(String.self, forKey: .bloodType)
        knownMedicalConditions = try values.decode(String.self, forKey: .knownMedicalConditions)
        knownPrescriptionMedicationsBeingTaken = try values.decode(String.self, forKey: .knownPrescriptionMedicationsBeingTaken)
        knownAllergies = try values.decode(String.self, forKey: .knownAllergies)
    }
}


extension DronAccount: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deviceId, forKey: .deviceId)
        try container.encode(address, forKey: .address)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(emergencyContactPerson, forKey: .emergencyContactPerson)
        try container.encode(emergencyContactNumber, forKey: .emergencyContactNumber)
        try container.encode(emergencyContactEmail, forKey: .emergencyContactEmail)
        try container.encode(bloodType, forKey: .bloodType)
        try container.encode(knownMedicalConditions, forKey: .knownMedicalConditions)
        try container.encode(knownPrescriptionMedicationsBeingTaken, forKey: .knownPrescriptionMedicationsBeingTaken)
        try container.encode(knownAllergies, forKey: .knownAllergies)
    }
}

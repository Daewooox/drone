//
//  DronAccount.swift
//  Dron
//
//  Created by Dmtech on 22.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit


//String deviceId;
//String contactInformation;
//String medicalData;
//String emergencyContactInformation


struct DronAccount {
    var deviceId: String
    var contactInformation: String
    var medicalData: String
    var emergencyContactInformation: String
    
    enum CodingKeys : String, CodingKey {
        case deviceId
        case contactInformation
        case medicalData
        case emergencyContactInformation
    }
}


extension DronAccount: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        deviceId = try values.decode(String.self, forKey: .deviceId)
        contactInformation = try values.decode(String.self, forKey: .contactInformation)
        medicalData = try values.decode(String.self, forKey: .medicalData)
        emergencyContactInformation = try values.decode(String.self, forKey: .emergencyContactInformation)
    }
}


extension DronAccount: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deviceId, forKey: .deviceId)
        try container.encode(contactInformation, forKey: .contactInformation)
        try container.encode(medicalData, forKey: .medicalData)
        try container.encode(emergencyContactInformation, forKey: .emergencyContactInformation)
    }
}

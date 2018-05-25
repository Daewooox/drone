//
//  DronLocation.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

//Long id;
//String name;
//String serialNumber;
//Timestamp createdAt

import Foundation

struct DronDTO {
    let id: UInt64
    let name: String
    let serialNumber: String
    let date: UInt64
    
    enum CodingKeys : String, CodingKey {
        case date = "createdAt"
        case name
        case serialNumber
        case id
    }
}

extension DronDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        serialNumber = try values.decode(String.self, forKey: .serialNumber)
        date = try values.decode(UInt64.self, forKey: .date)
    }
}


extension DronDTO: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(name, forKey: .name)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(id, forKey: .id)
    }
}

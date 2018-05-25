//
//  DronMissionDTO.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

//Long id;
//String name;
//List<LocationDTO> locations;
//Timestamp createdAt

struct DronMissionDTO {
    let id: UInt64
    let name: String
    let locations: [DronLocationDTO]
    let date: UInt64
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case locations
        case date = "createdAt"
    }
}

extension DronMissionDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        locations = try values.decode(Array.self, forKey: .locations)
        name = try values.decode(String.self, forKey: .name)
        date = try values.decode(UInt64.self, forKey: .date)
    }
}

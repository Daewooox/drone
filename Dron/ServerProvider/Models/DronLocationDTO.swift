//
//  DronLocationDTO.swift
//  Dron
//
//  Created by Dmtech on 17.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

//Long id;
//Double latitude;
//Double longitude;
//Timestamp createdAt

struct DronLocationDTO {
    let id: UInt64
    let latitude: UInt64
    let longitude: UInt64
    let date: UInt64
    
    enum CodingKeys : String, CodingKey {
        case date = "createdAt"
        case latitude
        case longitude
        case id
    }
}

extension DronLocationDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        latitude = try values.decode(UInt64.self, forKey: .latitude)
        longitude = try values.decode(UInt64.self, forKey: .longitude)
        date = try values.decode(UInt64.self, forKey: .date)
    }
}

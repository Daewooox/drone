//
//  DronUpdatingLocation.swift
//  Dron
//
//  Created by Dmtech on 22.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

struct DronUpdatingLocation {
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


extension DronUpdatingLocation: Decodable
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


extension DronUpdatingLocation: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(date, forKey: .date)
    }
}

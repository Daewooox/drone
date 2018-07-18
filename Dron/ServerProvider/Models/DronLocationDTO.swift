//
//  DronLocationDTO.swift
//  Dron
//
//  Created by Dmtech on 17.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

struct DronLocationDTO {
    let latitude: Double
    let longitude: Double

    enum CodingKeys : String, CodingKey {
        case latitude
        case longitude
    }
}

extension DronLocationDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}

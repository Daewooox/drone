//
//  DronMissionInfoDTO.swift
//  Dron
//
//  Created by Alexander on 11.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

struct DronMissionInfoDTO {
    let id: UInt64?
    let accountId: UInt64
    let droneId: UInt64
    let locations: [DronLocationDTO]
    let status: String
    let date: UInt64
    
    enum CodingKeys : String, CodingKey {
        case id
        case accountId
        case droneId
        case locations = "waypoint"
        case status
        case date = "createdAt"
    }
}

extension DronMissionInfoDTO: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(UInt64.self, forKey: .id)
        accountId = try values.decode(UInt64.self, forKey: .accountId)
        droneId = try values.decode(UInt64.self, forKey: .droneId)
        locations = try values.decode([DronLocationDTO].self, forKey: .locations)
        status = try values.decode(String.self, forKey: .status)
        date = try values.decode(UInt64.self, forKey: .date)
    }
}

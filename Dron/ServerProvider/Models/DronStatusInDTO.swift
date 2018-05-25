//
//  DronStatusDTO.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

//Long id;
//Long idDrone;
//LocationDTO location;
//Integer batteryValue;
//String status;

import Foundation

struct DronStatusInDTO {
    let id: UInt64
    let drone: DronDTO
    let batteryValue: UInt
    let status: String
    let location: DronLocationDTO
    
    enum CodingKeys : String, CodingKey {
        case id
        case drone
        case status
        case batteryValue
        case location
    }
}

extension DronStatusInDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt64.self, forKey: .id)
        drone = try values.decode(DronDTO.self, forKey: .drone)
        batteryValue = try values.decode(UInt.self, forKey: .batteryValue)
        status = try values.decode(String.self, forKey: .status)
        location = try values.decode(DronLocationDTO.self, forKey: .location)
    }
}

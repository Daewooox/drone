//
//  DronSosRequestStatusDTO.swift
//  Dron
//
//  Created by Dmtech on 23.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

//Long requestId;
//private String requestStatus

struct DronSosRequestStatusDTO {
    let requestId: UInt64
    let requestStatus: String
    
    enum CodingKeys : String, CodingKey {
        case requestStatus
        case requestId
    }
}


extension DronSosRequestStatusDTO: Decodable
{
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestId = try values.decode(UInt64.self, forKey: .requestId)
        requestStatus = try values.decode(String.self, forKey: .requestStatus)
    }
}


extension DronSosRequestStatusDTO: Encodable
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requestId, forKey: .requestId)
        try container.encode(requestStatus, forKey: .requestStatus)
    }
}

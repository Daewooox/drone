//
//  DronEndpoints.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

var dronBaseEndpoint = "http://178.172.209.29:8888/drone-server-be/";

func getMissionEndpoint() -> String {
    return dronBaseEndpoint + "mission"
}


func postLocationEndpoint() -> String {
    return dronBaseEndpoint + "mission"
}


func registerAccountEndpoint() -> String {
    return dronBaseEndpoint + "account"
}


func addStatusEndpoint() -> String {
    return dronBaseEndpoint + "status"
}


///account/{deviceId}/sos
func addSosRequstEndpoint(udid: String) -> String {
    return dronBaseEndpoint + "account" + udid + "/sos"
}


///account/{deviceId}/sos/{requestId}


func addLocationEndpoint(udid: String, requestID: UInt64) -> String {
    let url = "\(dronBaseEndpoint)account/ \(udid) /sos/ \(requestID)"
    return url
}


func cancelSosRequstEndpoint(udid: String, requestID: String) -> String {
    return dronBaseEndpoint + "/account" + udid + "/sos" + requestID
}


func getStatusEndpoint() -> String {
    return dronBaseEndpoint + "/status"
}


func getDronesEndpoint() -> String {
    return dronBaseEndpoint + "/drone"
}


func addDroneEndpoint() -> String {
    return dronBaseEndpoint + "/drone"
}

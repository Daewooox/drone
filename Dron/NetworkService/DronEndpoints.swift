//
//  DronEndpoints.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

var dronBaseEndpoint = "http://52.174.139.191:8080/drone-server-be/";

func getMissionEndpoint() -> String {
    return dronBaseEndpoint + "mission"
}


func postLocationEndpoint() -> String {
    return dronBaseEndpoint + "mission"
}


func registerAccountEndpoint() -> String {
    return dronBaseEndpoint + "account"
}


func checkAccountEndpoint(udid: String) -> String {
    let url = "\(dronBaseEndpoint)account/\(udid)"
    return url
}


func addStatusEndpoint() -> String {
    return dronBaseEndpoint + "status"
}


///account/{deviceId}/sos
func addSosRequstEndpoint(udid: String) -> String {
    let url = "\(dronBaseEndpoint)account/\(udid)/sos"
    return url
}


///account/{deviceId}/sos/{requestId}


func addLocationEndpoint(udid: String, requestID: UInt64) -> String {
    let url = "\(dronBaseEndpoint)account/\(udid)/sos/\(requestID)/location"
    return url
}


func cancelSosRequstEndpoint(udid: String, requestID: UInt64) -> String {
    let url = "\(dronBaseEndpoint)account/\(udid)/sos/\(requestID)"
    return url
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

func missionInfoEndpoint(deviceId: String) -> String {
    return "\(dronBaseEndpoint)account/\(deviceId)/mission/inprogress"
}

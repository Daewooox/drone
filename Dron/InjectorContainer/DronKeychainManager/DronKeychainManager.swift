//
//  DronKeychainManager.swift
//  Dron
//
//  Created by Dmtech on 22.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit
import KeychainSwift

var DronKeychainManagerAccountKey = "DronKeychainManager24";

protocol DronKeychainManagerInjection {
    
}

protocol DronKeychainManagerProtocol {
    func isUserExist() -> Bool
    func registerNewUser(account: DronAccount) -> Void
    func removeCurrentUser() -> Void
    func getUserID() -> String
    func getCurrentUser() -> DronAccount?
}

class DronKeychainManager: DronKeychainManagerProtocol {
    func isUserExist() -> Bool {
        let keychain = KeychainSwift()
        let dronAccountStr = keychain.get(DronKeychainManagerAccountKey)
        if dronAccountStr == nil {
            return false
        }
        do {
            let accountData = dronAccountStr?.data(using: .utf8)
            let accountDTO =  try JSONDecoder().decode(DronAccount.self, from: accountData!)
            if accountDTO != nil {
                return true
            }
            return false
        }
        catch {
            
        }
        return false
    }
    
    
    func getCurrentUser() -> DronAccount? {
        let keychain = KeychainSwift()
        let dronAccountStr = keychain.get(DronKeychainManagerAccountKey)
        if dronAccountStr == nil {
            return nil
        }
        do {
            let accountData = dronAccountStr?.data(using: .utf8)
            let accountDTO =  try JSONDecoder().decode(DronAccount.self, from: accountData!)
            return accountDTO
        }
        catch {
            
        }
        return nil
    }
    
    
    func registerNewUser(account: DronAccount) -> Void {
        do {
            let accountData =  try JSONEncoder().encode(account)
            let accountString = String(data: accountData, encoding: .utf8)
            
            if accountString != nil {
                let keychain = KeychainSwift()
                keychain.set(accountString!, forKey: DronKeychainManagerAccountKey)
            }
        }
        catch {
            
        }
    }
    
    
    func getUserID() -> String {
        let keychain = KeychainSwift()
        let dronAccountStr = keychain.get(DronKeychainManagerAccountKey)
        if dronAccountStr == nil {
            return ""
        }
        do {
            let accountData = dronAccountStr?.data(using: .utf8)
            let accountDTO =  try JSONDecoder().decode(DronAccount.self, from: accountData!)
            if accountDTO != nil {
                return accountDTO.deviceId
            }
            return ""
        }
        catch {
            
        }
        return ""
    }
    
    
    func removeCurrentUser() -> Void {
        let keychain = KeychainSwift()
        keychain.delete(DronKeychainManagerAccountKey)
    }
}

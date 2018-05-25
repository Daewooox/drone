//
//  InjectorContainer.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation

class InjectorContainer : DronNetworkServiceInjection,
                          DronServerProviderInjection,
                          DronUIManagerInjection,
                          DronLocationManagerInjection,
                          DronKeychainManagerInjection {
    
    static let shared = InjectorContainer()
    
    lazy var dronNetworkService: DronNetworkServiceProtocol = {
        return DronNetworkService(aInjection: self);
    }()
    
    lazy var dronServerProvider: DronServerProviderProtocol = {
        return DronServerProvider(aInjection: self);
    }()
    
    lazy var dronUIManager: DronUIManagerProtocol = {
        return DronUIManager(aInjection: self);
    }()
    
    lazy var dronLocationManager: DronLocationManagerProtocol = {
        return DronLocationManager(aInjection: self);
    }()
    lazy var dronKeychainManager: DronKeychainManagerProtocol = {
        return DronKeychainManager();
    }()
    
}

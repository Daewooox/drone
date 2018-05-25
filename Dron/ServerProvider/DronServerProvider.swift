//
//  DronServerProvider.swift
//  Dron
//
//  Created by Dmtech on 16.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import CoreLocation

typealias DronServerProviderCompletionHandler = (_ result: Any?, _ error: NSError?) -> (Void)

protocol DronServerProviderInjection {
    var dronNetworkService: DronNetworkServiceProtocol { get set };
    var dronKeychainManager: DronKeychainManagerProtocol { get set };
}

protocol DronServerProviderProtocol {
    func getDronMission(droneID: UInt64, completion: DronServerProviderCompletionHandler) -> Void
    func getAllDronesWithCompletion(completion: DronServerProviderCompletionHandler) -> Void
    
    func registerNewAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void
    func updateAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void
    func sendUpdatingLocation(location: CLLocationCoordinate2D)->Void
    func addSosRequest(location: CLLocationCoordinate2D) -> Void
}


class DronServerProvider : DronServerProviderProtocol {
    
    var injection : DronServerProviderInjection?
    var currentSOSRequest : DronSosRequestStatusDTO?
    
    init(aInjection:DronServerProviderInjection) {
        injection = aInjection;
    }
    
    func registerNewAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void {
        do {
            let accountData =  try JSONEncoder().encode(accountDTO)
            guard let dictionary = try JSONSerialization.jsonObject(with: accountData, options: .allowFragments) as? [String: Any] else {
                throw NSError()
            }
            print(dictionary);
            injection?.dronNetworkService.postWithURL(url: registerAccountEndpoint(), params: dictionary, completion: { (responce, error) -> (Void) in
                InjectorContainer.shared.dronKeychainManager.registerNewUser(account: accountDTO)
            })
        }
        catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
    }
    
    
    func updateAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void {
        do {
            let accountData =  try JSONEncoder().encode(accountDTO)
            guard let dictionary = try JSONSerialization.jsonObject(with: accountData, options: .allowFragments) as? [String: Any] else {
                throw NSError()
            }
            print(dictionary);
            injection?.dronNetworkService.putWithURL(url: registerAccountEndpoint(), params: dictionary, completion: { (responce, error) -> (Void) in
                InjectorContainer.shared.dronKeychainManager.registerNewUser(account: accountDTO)
            })
        }
        catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
    }
    
    
    func addSosRequest(location: CLLocationCoordinate2D) -> Void {
        let locationDictionary: Dictionary<String, Double> = ["latitude" : location.latitude, "longitude" : location.longitude]
        injection?.dronNetworkService.postWithURL(url:addSosRequstEndpoint(udid: (injection?.dronKeychainManager.getUserID())!), params: locationDictionary, completion: { (responce, error) -> (Void) in
            do {
                let animeJsonStuff =  try JSONDecoder().decode([DronSosRequestStatusDTO].self, from: responce!)
                print(animeJsonStuff);
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        })
    }
    
    
    func sendUpdatingLocation(location: CLLocationCoordinate2D)->Void {
        let locationDictionary: Dictionary<String, Double> = ["latitude" : location.latitude, "longitude" : location.longitude]
        if currentSOSRequest != nil {
            injection?.dronNetworkService.postWithURL(url: addLocationEndpoint(udid: (injection?.dronKeychainManager.getUserID())!, requestID: (currentSOSRequest?.requestId)!), params: locationDictionary, completion: { (responce, error) -> (Void) in
                
            })
        }
    }
    
    
    func getAllDronesWithCompletion(completion: (Any?, NSError?) -> (Void)) {
        injection?.dronNetworkService.getWithURL(url: getDronesEndpoint(), params: nil) { (responce, error) -> (Void) in
            do {
                let animeJsonStuff =  try JSONDecoder().decode([DronDTO].self, from: responce!)
                print(animeJsonStuff);
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }
    }
    
    func getDronMission(droneID: UInt64, completion: DronServerProviderCompletionHandler) -> Void {
        injection?.dronNetworkService.getWithURL(url: getMissionEndpoint(), params: ["droneId" : droneID]) { (responce, error) -> (Void) in
            
        }
    }
}

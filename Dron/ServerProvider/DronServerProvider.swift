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
    var dronUIManager: DronUIManagerProtocol { get set };
}

protocol DronServerProviderProtocol {

    func registerNewAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void
    func checkExsitingAccount(deviceID: String, completion: @escaping DronServerProviderCompletionHandler) -> Void
    func updateAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void
    
    func sendUpdatingLocation(location: CLLocationCoordinate2D)->Void
    
    func addSosRequest(location: CLLocationCoordinate2D) -> Void
    func cancelSosRequest() -> Void
}


class DronServerProvider : DronServerProviderProtocol {
    
    var injection : DronServerProviderInjection?
    var currentSOSRequest : DronSosRequestStatusDTO?
    
    init(aInjection:DronServerProviderInjection) {
        injection = aInjection;
    }
    
    func checkExsitingAccount(deviceID: String, completion: @escaping DronServerProviderCompletionHandler) -> Void {
        injection?.dronNetworkService.getWithURL(url: checkAccountEndpoint(udid: deviceID), params: nil, completion: { (responce, error) -> (Void) in
            let result = (responce != nil) as Bool
            if responce != nil {
                completion(result, nil)
            }
        })
    }
    
    
    func registerNewAccount(accountDTO: DronAccount, completion: DronServerProviderCompletionHandler) -> Void {
        do {
            let accountData =  try JSONEncoder().encode(accountDTO)
            guard let dictionary = try JSONSerialization.jsonObject(with: accountData, options: .allowFragments) as? [String: Any] else {
                throw NSError()
            }
            print(dictionary);
            injection?.dronNetworkService.postWithURL(url: registerAccountEndpoint(), params: dictionary, completion: { (responce, error) -> (Void) in
                if error == nil {
                    self.injection?.dronUIManager.showSuccessBanner(text: "Account was registered successfully")
                    InjectorContainer.shared.dronKeychainManager.registerNewUser(account: accountDTO)
                }
                else {
                    self.injection?.dronUIManager.showUnsuccessBanner(text: "Account was registered unsuccessfully")
                }
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
                if error == nil {
                    self.injection?.dronUIManager.showSuccessBanner(text: "Account was updated successfully")
                    InjectorContainer.shared.dronKeychainManager.registerNewUser(account: accountDTO)
                }
                else {
                    self.injection?.dronUIManager.showUnsuccessBanner(text: "Account was updated unsuccessfully")
                }
            })
        }
        catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
    }
    
    
    func addSosRequest(location: CLLocationCoordinate2D) -> Void {
        let locationDictionary: Dictionary<String, String> = ["latitude" : "\(location.latitude)", "longitude" : "\(location.longitude)"]
        let url = addSosRequstEndpoint(udid: (injection?.dronKeychainManager.getUserID())!)
        let urlComps = NSURLComponents(string: url)!
        let queryItems = self.queryItems(dictionary: locationDictionary)
        urlComps.queryItems = queryItems
        injection?.dronNetworkService.postWithURL(url:urlComps.url!.absoluteString, params: locationDictionary, completion: { (responce, error) -> (Void) in
            if error == nil {
                self.injection?.dronUIManager.showSuccessBanner(text: "SOS request was made successfully")
                do {
                    let statusDTO =  try JSONDecoder().decode(DronSosRequestStatusDTO.self, from: responce!)
                    self.currentSOSRequest = statusDTO
                    print(statusDTO);
                }
                catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
            }
            else {
                self.injection?.dronUIManager.showUnsuccessBanner(text: "SOS request was made unsuccessfully")
            }
        })
    }
    
    
    func cancelSosRequest() -> Void {
        if self.currentSOSRequest == nil {
            return
        }
        
        let url = cancelSosRequstEndpoint(udid: (injection?.dronKeychainManager.getUserID())!, requestID: (currentSOSRequest?.requestId)!)
        injection?.dronNetworkService.deleteWithURL(url: url, params: nil, completion: { (responce, error) -> (Void) in
            if error == nil {
                self.currentSOSRequest = nil
                self.injection?.dronUIManager.showSuccessBanner(text: "SOS was canceled successfully")
            }
            else {
                self.injection?.dronUIManager.showUnsuccessBanner(text: "SOS was canceled unsuccessfully")
            }
        })
    }
    
    
    func sendUpdatingLocation(location: CLLocationCoordinate2D)->Void {
        if currentSOSRequest == nil {
            return
        }
        let locationDictionary: Dictionary<String, String> = ["latitude" : "\(location.latitude)", "longitude" : "\(location.longitude)"]
        let url = addLocationEndpoint(udid: (injection?.dronKeychainManager.getUserID())!, requestID: (currentSOSRequest?.requestId)!)
        let urlComps = NSURLComponents(string: url) ?? NSURLComponents()
        let queryItems = self.queryItems(dictionary: locationDictionary)
        urlComps.queryItems = queryItems
        
        if currentSOSRequest != nil {
            injection?.dronNetworkService.postWithURL(url: urlComps.url!.absoluteString, params: locationDictionary, completion: { (responce, error) -> (Void) in
                if error == nil {
                    self.injection?.dronUIManager.showSuccessBanner(text: "Location was updated successfully")
                }
                else {
                    self.injection?.dronUIManager.showUnsuccessBanner(text: "Location was updated unsuccessfully")
                }
            })
        }
    }
    
    
    func queryItems(dictionary: [String:String]) -> [URLQueryItem] {
        return dictionary.map {
            // Swift 4
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}

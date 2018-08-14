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
    
    func addSosRequest(location: CLLocationCoordinate2D, completion: @escaping DronServerProviderCompletionHandler) -> Void
    func cancelSosRequest(completion: @escaping DronServerProviderCompletionHandler) -> Void
    func getMissionStatus(completion: @escaping DronServerProviderCompletionHandler) -> Void
    func getMissionInfoDTO() -> DronMissionInfoDTO?
    
    func isDronOnTheMission() -> Bool
}


class DronServerProvider : DronServerProviderProtocol {
    
    var injection : DronServerProviderInjection?
    var currentSOSRequest : DronSosRequestStatusDTO?
    var missionInfoDTO: DronMissionInfoDTO?
    
    init(aInjection:DronServerProviderInjection) {
        injection = aInjection;
    }
    
    func checkExsitingAccount(deviceID: String, completion: @escaping DronServerProviderCompletionHandler) -> Void {
        injection?.dronNetworkService.getWithURL(url: checkAccountEndpoint(udid: deviceID), params: nil, completion: { (responce, error) -> (Void) in
            if responce != nil {
                let datastring = NSString(data: responce!, encoding: String.Encoding.utf8.rawValue)
                let result = datastring?.isEqual(to: "true")
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
    
    
    func addSosRequest(location: CLLocationCoordinate2D, completion: @escaping DronServerProviderCompletionHandler) -> Void {
        let locationDictionary: Dictionary<String, String> = ["latitude" : "\(location.latitude)", "longitude" : "\(location.longitude)"]
        let url = addSosRequstEndpoint(udid: (injection?.dronKeychainManager.getUserID())!)
//                let url = addSosRequstEndpoint(udid: UUID().uuidString)
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
                    if (self.currentSOSRequest != nil) {
                        self.getCurrentMissionInfo()
                        completion(true, nil)
                    }
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
    
    
    func isDronOnTheMission() -> Bool {
        if self.currentSOSRequest == nil {
            return false
        }
        return true
    }
    
    func cancelSosRequest(completion: @escaping DronServerProviderCompletionHandler) -> Void {
        if self.currentSOSRequest == nil {
            return
        }
        
        let url = cancelSosRequstEndpoint(udid: (injection?.dronKeychainManager.getUserID())!, requestID: (currentSOSRequest?.requestId)!)
        injection?.dronNetworkService.deleteWithURL(url: url, params: nil, completion: { (responce, error) -> (Void) in
            if error == nil {
                self.currentSOSRequest = nil
                self.injection?.dronUIManager.showSuccessBanner(text: "SOS was canceled successfully")
                self.missionInfoDTO = nil
                completion(true, nil)
            }
            else {
                self.injection?.dronUIManager.showUnsuccessBanner(text: "SOS was canceled unsuccessfully")
                completion(false, NSError(domain: "", code: 0, userInfo: [:]))
            }
        })
    }
    
    func getMissionStatus(completion: @escaping DronServerProviderCompletionHandler) -> Void {
        if self.currentSOSRequest == nil {
            return
        }
        let url = getMissionStatusEndpoint(udid: (injection?.dronKeychainManager.getUserID())!, requestID: (currentSOSRequest?.requestId)!)
        injection?.dronNetworkService.getWithURL(url: url, params: nil, completion: { (responce, error) -> (Void) in
            if error == nil {
                do {
                    let statusDTO = try JSONDecoder().decode(DronSosRequestStatusDTO.self, from: responce!)
                    self.currentSOSRequest = statusDTO
                    if statusDTO.requestStatus == "completed" {
                        self.currentSOSRequest = nil
                        self.missionInfoDTO = nil
                    }
                    completion(statusDTO, nil)
                }
                catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
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
    
    func getCurrentMissionInfo() {
    //  id for test
    // http://52.174.139.191:8080/drone-server-be/account/EBF91021-4CFD-4358-A937-D600682F4423/mission/inprogress
        injection?.dronNetworkService.getWithURL(url: missionInfoEndpoint(deviceId: (injection?.dronKeychainManager.getUserID())!), params: nil, completion: { (response, error) -> (Void) in
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let missionInfoDTO =  try decoder.decode(DronMissionInfoDTO.self, from:response!)
                    self.missionInfoDTO = missionInfoDTO
                    print(missionInfoDTO)
                }
                catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
            }
            
        })
    }
    
    func getMissionInfoDTO() -> DronMissionInfoDTO? {
        return self.missionInfoDTO
    }
    
    func queryItems(dictionary: [String:String]) -> [URLQueryItem] {
        return dictionary.map {
            // Swift 4
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}

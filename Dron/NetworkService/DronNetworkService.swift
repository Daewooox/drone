//
//  DronNetworkService.swift
//  Dron
//
//  Created by Dmtech on 15.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import Alamofire

typealias DronNetworkServiceCompletionHandler = (_ result: Data?, _ error: NSError?) -> (Void)

protocol DronNetworkServiceInjection {
    var dronUIManager: DronUIManagerProtocol { get set };
}


protocol DronNetworkServiceProtocol {

    func getWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void
    func postWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void
    func putWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void
    func deleteWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void
}


public class DronNetworkService: DronNetworkServiceProtocol {
    var urlSession : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    var injection : DronNetworkServiceInjection?
    
    init(aInjection:DronNetworkServiceInjection) {
        injection = aInjection;
    }
    
    
    func getWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void {
        makeRequest(method: .get, url: url, params: params) { (data, error) -> (Void) in
            completion(data, error)
        }
    }
    func postWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void {
        makeRequest(method: .post, url: url, params: params) { (data, error) -> (Void) in
            completion(data, error)
        }
    }
    
    
    func deleteWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void {
        makeRequest(method: .delete, url: url, params: params) { (data, error) -> (Void) in
            completion(data, error)
        }
    }
    
    
    func putWithURL(url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void {
        makeRequest(method: .put, url: url, params: params) { (data, error) -> (Void) in
            completion(data, error)
        }
    }
    
    
    internal func makeRequest(method: HTTPMethod, url: String, params: Dictionary<String, Any>?, completion: @escaping DronNetworkServiceCompletionHandler) -> Void {
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil).response { (responce) in
            if responce.response?.statusCode == 200 {
                completion(responce.data, nil);
            }
            else {
                completion(nil, NSError(domain: "Error", code: 1, userInfo: nil));
            }
        }
    }
}

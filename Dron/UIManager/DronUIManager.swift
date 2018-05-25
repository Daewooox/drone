//
//  DronUIManager.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit

protocol DronUIManagerInjection {
    
}

protocol DronUIManagerProtocol {
    func loadMainUI() -> Void
}


class DronUIManager : DronUIManagerProtocol {
    
    var injection : DronUIManagerInjection?
    
    init(aInjection:DronUIManagerInjection) {
        injection = aInjection;
    }
    
    func loadMainUI() -> Void {
        let tabbarConroller : UITabBarController = UITabBarController()
        let dronVC: UIViewController = DronControlViewController();
        let accountVC: UIViewController = DronAccountViewController();
        let accountNavVC : UINavigationController = UINavigationController(rootViewController: accountVC);
        
        let accountImage  = UIImage(named: "accountTabbarImage")
        let accountSelImage = UIImage(named: "accountSelImage")
        accountNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Account", comment: "Account"), image: accountImage, selectedImage: accountSelImage)
        
        let dronImage  = UIImage(named: "accountTabbarImage")
        let drontSelImage = UIImage(named: "accountSelImage")
        dronVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Drone", comment: "Drone"), image: dronImage, selectedImage: drontSelImage)
        
        
        
        tabbarConroller.viewControllers = [dronVC, accountNavVC];
        tabbarConroller.tabBar.barTintColor = UIColor.Tabbar.background
        let window : UIWindow = UIApplication.shared.windows.first!
        window.rootViewController = tabbarConroller;
        
        UINavigationBar.appearance().tintColor = UIColor.Navbar.tint
        UINavigationBar.appearance().backgroundColor = UIColor.Navbar.background
    }
}

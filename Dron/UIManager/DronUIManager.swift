//
//  DronUIManager.swift
//  Dron
//
//  Created by Dmtech on 18.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

protocol DronUIManagerInjection {
    
}

protocol DronUIManagerProtocol {
    func loadMainUI() -> Void
    func showSuccessBanner(text: String) -> Void
    func showUnsuccessBanner(text: String) -> Void
    func presentUserLocationVC()
}


class DronUIManager : DronUIManagerProtocol {
    
    lazy var tabbarConroller = UITabBarController()
    var injection : DronUIManagerInjection?
    
    init(aInjection:DronUIManagerInjection) {
        injection = aInjection;
    }
    
    func loadMainUI() -> Void {
        let dronVC: UIViewController = DronControlViewController();
        let accountVC: UIViewController = DronAccountViewController();
        let missionVC: UIViewController = DronMissionInfoViewController();
        let accountNavVC : UINavigationController = UINavigationController(rootViewController: accountVC);
        let missionNavVC : UINavigationController = UINavigationController(rootViewController: missionVC);
        
        tabbarConroller.tabBar.isTranslucent = false
        tabbarConroller.tabBar.barStyle = .black
        tabbarConroller.tabBar.tintColor = UIColor.Tabbar.background
        
        var accountImage : UIImage  = UIImage(named: "icon-account-inactive-")!
        var accountSelImage : UIImage = UIImage(named: "icon-account-active-")!
        accountImage = accountImage.withRenderingMode(.alwaysOriginal)
        accountSelImage = accountSelImage.withRenderingMode(.alwaysOriginal)
        
        accountNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Account", comment: "Account"), image: accountImage, selectedImage: accountSelImage)
        accountVC.title = "Account"
        
        var missionImage : UIImage  = UIImage(named: "icon-mission-inactive-")!
        var missionSelImage : UIImage = UIImage(named: "icon-mission-active-")!
        missionImage = missionImage.withRenderingMode(.alwaysOriginal)
        missionSelImage = missionSelImage.withRenderingMode(.alwaysOriginal)
        
        missionNavVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Mission", comment: "Mission"), image: missionImage, selectedImage: missionSelImage)
        missionVC.title = NSLocalizedString("Mission", comment: "Mission")
        
        var dronImage : UIImage  = UIImage(named: "icon-drone-inactive-")!
        dronImage = dronImage.withRenderingMode(.alwaysOriginal)
        var drontSelImage : UIImage = UIImage(named: "icon-drone-active-")!
        drontSelImage = drontSelImage.withRenderingMode(.alwaysOriginal)
        
        dronVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Drone", comment: "Drone"), image: dronImage, selectedImage: drontSelImage)
        
        tabbarConroller.viewControllers = [dronVC, missionNavVC, accountNavVC];
        tabbarConroller.tabBar.barTintColor = UIColor.Tabbar.background
        let window : UIWindow = UIApplication.shared.windows.first!
        window.rootViewController = tabbarConroller;
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.Tabbar.titleColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.Tabbar.titleSelectedColor], for: .selected)
        
        UINavigationBar.appearance().tintColor = UIColor.Navbar.tint
        UINavigationBar.appearance().backgroundColor = UIColor.Navbar.background
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.Navbar.tint
        UINavigationBar.appearance().barStyle = .black
    }
    
    func presentUserLocationVC() {
        let vc = DronUserLocationViewController()
        tabbarConroller.present(vc, animated: true, completion: nil)
    }
    
    func showSuccessBanner(text: String) -> Void {
        NotificationBannerQueue.default.removeAll()
        
        let banner = NotificationBanner(title: text, subtitle: "", style: .success)
        banner.show()
    }
    
    func showUnsuccessBanner(text: String) -> Void {
        NotificationBannerQueue.default.removeAll()
        
        let banner = NotificationBanner(title: text, subtitle: "", style: .danger)
        banner.show()
    }
}

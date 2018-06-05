//
//  ColorExtension.swift
//  Dron
//
//  Created by Dmtech on 21.05.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    struct Tabbar {
        static let background = UIColor(netHex: 0x000000)
        static let titleColor = UIColor(netHex: 0xb1d0e4)
        static let titleSelectedColor = UIColor(netHex: 0xffffff)
    }
    struct Navbar {
        static let background = UIColor(netHex: 0x000000)
        static let tint = UIColor(netHex: 0x000000)
    }
    struct DronButton {
        static let background = UIColor(netHex: 0x000000)
        static let backgroundSelected = UIColor(netHex: 0x000000)
        static let tint = UIColor(netHex: 0x3f5f78)
        static let borderColor = UIColor(netHex: 0x000000)
        static let borderColorSelected = UIColor(netHex: 0xffffff)
    }
    struct AccountViewController {
        static let textFieldTextColor = UIColor(netHex: 0x6b6b6b)
        static let textFieldBackgroundColor = UIColor(netHex: 0xffffff)
        static let textFieldBorderColor = UIColor(netHex: 0x000000)
    }
    struct ViewController {
        static let background = UIColor(netHex: 0xdaedfd)
    }
}

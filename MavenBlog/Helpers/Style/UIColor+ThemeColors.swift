//
//  Colors.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let mavenBackgroundGreen = UIColor(red: 220/255, green: 233/255, blue: 226/255, alpha: 1)
    static let mavenDarkGreen = UIColor(red: 0/255, green: 133/255, blue: 111/255, alpha: 1)
    
    static let mavenGreen = UIColor.init(hex: "#00856F")
    static let mavenDarkG = UIColor.init(hex: "#00413E")
    static let mavenLightGreen = UIColor.init(hex: "#DCE9E2")
    static let mavenGrey = UIColor.init(hex: "#B7C0C0")
    static let mavenRed = UIColor.init(hex: "#CB4C48")
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

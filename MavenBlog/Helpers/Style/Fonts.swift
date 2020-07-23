//
//  Fonts.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func makeTitleFont(size: CGFloat) -> UIFont {
        let font = UIFont(name: "AvenirNext-Heavy", size: size)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
        
    }
    
    static func makeAvenirNext(size: CGFloat) -> UIFont? {
        let font = UIFont(name: "Avenir Next", size: size)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
    }
}

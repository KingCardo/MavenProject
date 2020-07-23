//
//  UIKit+Extension.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func createLabel(text: String = "",
                            textAlignment: NSTextAlignment = .center,
                            font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = textAlignment
        label.font = font
        return label
    }
}

extension UITextField {
    
    static func createTextField(minimumFontSize: CGFloat = 12,
                                adjustFontSizeToWidth: Bool = true,
                                font: UIFont,
                                placeHolder: String = "",
                                borderStyle: UITextField.BorderStyle = .roundedRect,
                                isSecureTextEntry: Bool = false) -> UITextField {
        let textfield = UITextField()
        textfield.minimumFontSize = minimumFontSize
        textfield.adjustsFontSizeToFitWidth = adjustFontSizeToWidth
        textfield.font = font
        textfield.placeholder = placeHolder
        textfield.borderStyle = borderStyle
        textfield.isSecureTextEntry = isSecureTextEntry
        return textfield
    }
}

//
//  UIAlert+extension.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func createAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = .dark
        let action = UIAlertAction(title: NSLocalizedString("OK"/*Messages.okButton*/, comment: ""/*Messages.emptyString*/),
                                   style: .default, handler: handler)
        alertController.addAction(action)
        return alertController
    }
}

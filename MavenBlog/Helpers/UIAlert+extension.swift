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
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                   style: .default, handler: handler)
        alertController.addAction(action)
        
        if handler != nil {
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                             style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
        }
        
        return alertController
    }
}

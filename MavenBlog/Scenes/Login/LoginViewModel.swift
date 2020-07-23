//
//  LoginViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Intents
    
    func submitCredentials(username: String, password: String, completion: @escaping(Error?) -> Void) {
        UserManager.shared.logIn(username: username, password: password) { error in
            completion(error)
            return
        }
    }
}

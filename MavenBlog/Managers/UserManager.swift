//
//  UserManager.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class UserManager {
    
    static var shared = UserManager()
    
    private init() { } // want to make sure clients can't create own instance
    
    private(set) var currentUser: User?
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.loggedInKey)
    }
    
    var userName: String? {
        if let name = UserDefaults.standard.object(forKey: UserDefaults.userNameKey) as? String {
            return name
        }
        return currentUser?.username
    }
    
    func logOutUser() {
        currentUser = nil
        UserDefaults.standard.set(false, forKey: UserDefaults.loggedInKey)
    }
    
    private var usersFavoritePosts: [Post] = [] // data store private provide read access thru favorite posts
    
    var favoritePosts: [Post] {
      return usersFavoritePosts
    }
    
    func resetFavoritePost() {
        usersFavoritePosts = []
    }
    
    func logIn(username: String, password: String, completion: @escaping (Error?) -> Void) {
        guard currentUser == nil else {
            completion(nil)
            return
        }
        
        // Simulate API request
        let valid = validateCredentials(username: username, password: password)
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 2.0) { [weak self] in
            if valid {
                self?.currentUser = User(username: username)
                UserDefaults.standard.set(true, forKey: UserDefaults.loggedInKey)
                completion(nil)
            } else {
                completion(NSError(domain: "com.mavenclinic", code: 123, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials."]))
            }
        }
    }
    
    private func validateCredentials(username: String, password: String) -> Bool {
        if username == "user" && password == "pass" {
            UserDefaults.standard.set(currentUser?.username, forKey: UserDefaults.userNameKey)
            return true
        }
        return false
    }
    
    func userDidFavoritePost(_ post: Post) {
        usersFavoritePosts.append(post)
        NotificationCenter.default.post(name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification),
                                        object: nil)
    }
    
    func userDidUnfavoritePost(_ post: Post) {
        usersFavoritePosts.removeAll { $0.id == post.id }
        NotificationCenter.default.post(name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification),
                                        object: nil)
    }
    
}

extension UserManager {
    static let FavoritesChangedNotification = "MavenBlogFavoritesChanged"
}

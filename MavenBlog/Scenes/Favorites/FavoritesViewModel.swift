//
//  FavoritesViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    
    var posts: [Post] {
           return UserManager.shared.favoritePosts
       }
}

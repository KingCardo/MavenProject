//
//  BlogListDetailViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class BlogListDetailViewModel {
    
    var post: Post!
    
    
    // MARK: - Intents
    
    func start(completion: @escaping(Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts/\(post.id)")!, completionHandler: { [weak self] data, response, error in
                   if error != nil {
                    completion(error)
                       return
                   }
                   
                   do {
                       let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                       self?.post = Post(json: json ?? [:])
                       
                           completion(nil)
                   } catch {
                        completion(error)
                   }
               }).resume()
        
    }
    
    func addToFavorites() {
        
        UserManager.shared.userDidFavoritePost(post)
        
    }
    
    func removeFromFavorites() {
         UserManager.shared.userDidUnfavoritePost(post)
    }
    
    func isPostFavorited(_ post: Post) -> Bool {
        return UserManager.shared.favoritePosts.map { $0.id }.contains(post.id)
    }
}

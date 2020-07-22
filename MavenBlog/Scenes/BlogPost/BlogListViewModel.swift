//
//  BlogListViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class BlogPostViewModel {
    
    var posts: [Post] = []
    
    let service: NetworkingService
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    // MARK: - Intents
    
    func login(completion: @escaping(Error?) -> Void) {
        //service.fetchData(completion: <#T##(Post?, Error?) -> Void#>)
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts")!, completionHandler: { [weak self] data, response, error in
            if error != nil {
                completion(error)
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
                let posts = (jsonArray ?? []).compactMap({ json -> Post? in
                  return Post(json: json)
                })
                self?.posts = posts
                completion(nil)
                
            } catch {
                completion(error)
            }
        }).resume()
        
    }
    
    func logOut() {
        UserManager.shared.logOutUser()
        UserManager.shared.resetFavoritePost()
    }
    
     func isPostFavorited(_ post: Post) -> Bool {
        return UserManager.shared.favoritePosts.map { $0.id }.contains(post.id)
    }
}

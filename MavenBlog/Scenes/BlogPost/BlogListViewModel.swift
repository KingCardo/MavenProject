//
//  BlogListViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class BlogPostViewModel {
    
    var posts: [Post] = [] {
        didSet {
            PostManager.shared.posts = posts
            PostManager.shared.save()
        }
    }
    
    let service: NetworkingService
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    // MARK: - Intents
    
    func login(completion: @escaping(Error?) -> Void) {
        
        // Added local persistence to prevent going over network every time for the same posts
        if let posts = PostManager.shared.load() {
            self.posts = posts
            completion(nil)
            return
            
        }
        
        service.get(url: Networking.url) { [weak self] (data, error) in
            if error != nil {
                completion(error)
                return
            }
            if let data = data {
                do {
                    guard let posts = try self?.service.decodePosts(data: data) else { completion(DecodingError.failed) ; return }
                    self?.posts = posts
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        }
    }
    
    func logOut() {
        UserManager.shared.logOutUser()
        UserManager.shared.resetFavoritePost()
    }
    
    func isPostFavorited(_ post: Post) -> Bool {
        return UserManager.shared.favoritePosts.map { $0.id }.contains(post.id)
    }
    
    enum DecodingError: Error {
        case failed
    }
}

//
//  BlogListDetailViewModel.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class BlogListDetailViewModel {
    
    var post: Post?
    
    let service: NetworkingService
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    
    // MARK: - Intents
    
    func start(completion: @escaping(Error?) -> Void) {
        
        guard let id = post?.id else  {
            return
        }
        
        service.get(url: Networking.url.appendingPathComponent("\(id)")) { [weak self] (data, error) in
            if error != nil {
                completion(error)
                return
            }
            
            if let data = data {
                do {
                    guard let post = try self?.service.decodePost(data: data) else {
                        completion(error)
                        return
                    }
                    self?.post = post
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        }
    }
    
    func addToFavorites() {
        guard let post = post else { return }
        UserManager.shared.userDidFavoritePost(post)
        
    }
    
    func removeFromFavorites() {
        guard let post = post else { return }
        UserManager.shared.userDidUnfavoritePost(post)
    }
    
    func isPostFavorited(_ post: Post) -> Bool {
        return UserManager.shared.favoritePosts.map { $0.id }.contains(post.id)
    }
}

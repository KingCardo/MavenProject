//
//  Networking.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class Networking: NetworkingService {
    
    static let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func decodePosts(data: Data) throws -> [Post]? {
        do {
            let result = try JSONDecoder().decode([Post].self, from: data)
            return result
        } catch {
            throw DecodingError.failed
        }
    }
    
    func decodePost(data: Data) throws -> Post? {
        do {
            let result = try JSONDecoder().decode(Post.self, from: data)
            return result
        } catch {
            throw DecodingError.failed
        }
    }
    
    func get(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    completion(data, nil)
                }
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    enum DecodingError: Error {
        case failed
    }
}

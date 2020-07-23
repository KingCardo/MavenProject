//
//  PostManager.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

class PostManager {
    
    static let postNotification = NSNotification.Name("PostNotification")
    private let KpostsFile = "Posts"
    private let format = "json"
    
    static var shared = PostManager()
    
    private init() { }
    
    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                 NotificationCenter.default.post(name: PostManager.postNotification, object: self)
            }
        }
    }
    
    func load() -> [Post]? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent(KpostsFile).appendingPathExtension(format)
        
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? Data(contentsOf: archiveURL) else { return nil }
        
        do {
            self.posts = try jsonDecoder.decode([Post].self, from: decodedData)
            return posts
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func save() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
              let archiveURL = documentsDirectory.appendingPathComponent(KpostsFile).appendingPathExtension(format)
              
              let jsonEncoder = JSONEncoder()
              
              do {
                  let encodedData = try jsonEncoder.encode(posts)
                  try encodedData.write(to: archiveURL)
              } catch let error {
                  print(error)
              }
        
    }
}

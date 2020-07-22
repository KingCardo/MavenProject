//
//  Post.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

struct Post {
    
    let id: Int
    let title: String
    let body: String?
    
    init?(json: [String : Any]) {
        self.id = (json[Post.kID] as? Int) ?? -1
        self.title = (json[Post.kTitle] as? String) ?? ""
        self.body = json[Post.kBody] as? String
    }
    
}

extension Post {
    static let kID = "id"
    static let kTitle = "title"
    static let kBody = "body"
}
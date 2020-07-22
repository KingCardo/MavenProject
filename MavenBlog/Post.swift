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
        self.id = (json["id"] as? Int) ?? -1
        self.title = (json["title"] as? String) ?? ""
        self.body = json["body"] as? String
    }
    
}

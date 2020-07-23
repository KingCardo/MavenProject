//
//  NetworkingService.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Foundation

protocol NetworkingService {
    func get(url: URL, completion: @escaping(Data?, Error?) -> Void)
    func decodePosts(data: Data) throws -> [Post]?
    func decodePost(data: Data) throws -> Post?
}

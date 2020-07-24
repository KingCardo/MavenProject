//
//  AlamoFire.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/24/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import Alamofire

class AlamoFire: NetworkingService {
    
    func get(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let dataRequest = AF.request(url).data
        
        if let data = dataRequest {
            completion(data, nil)
        } else {
            completion(nil, NetworkingError.DecodingError.failed)
        }
    }
    
//    func decodePosts(data: Data) throws -> [Post]? {
//        <#code#>
//    }
//
//    func decodePost(data: Data) throws -> Post? {
//        <#code#>
//    }
    
//    enum NetworkingError: Error {
//        case failed
//    }
    
    
}

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
        let _ = AF.request(url).responseData { (response) in
            if let data = response.data {
                completion(data, nil)
                return
            } else {
                completion(nil, NetworkingError.DecodingError.failed)
                return
            }
        }
    }
}

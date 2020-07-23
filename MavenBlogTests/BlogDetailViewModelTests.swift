//
//  BlogDetailViewModelTests.swift
//  MavenBlogTests
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

@testable import MavenBlog
import XCTest

class BlogDetailViewModelTests: XCTestCase {
    
    var sut: BlogListDetailViewModel!
    var post: Post!

    override func setUpWithError() throws {
        sut = BlogListDetailViewModel(service: Networking())
        post = Post()
    }

    override func tearDownWithError() throws {
        sut = nil
        post = nil
    }

}

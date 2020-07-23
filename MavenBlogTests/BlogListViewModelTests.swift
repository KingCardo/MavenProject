//
//  BlogListViewModelTests.swift
//  MavenBlogTests
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

@testable import MavenBlog
import XCTest

class BlogListViewModelTests: XCTestCase {
    
    var sut: BlogPostViewModel!

    override func setUpWithError() throws {
        sut = BlogPostViewModel(service: Networking())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

}

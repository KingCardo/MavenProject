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
    

    override func setUpWithError() throws {
        sut = BlogListDetailViewModel(service: Networking())
        sut.post = Post()
    }

    override func tearDownWithError() throws {
        sut.post = nil
        sut = nil
    }
    
    func testStartCompletioncalled() {
        
        var wasCalled = false
        let expectation = XCTestExpectation(description: "Completion was called")
        
        sut.start() { error in
            wasCalled = true
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 6.0)
        XCTAssertTrue(wasCalled)
    }
    
    func testAddToFavorites() {
        sut.addToFavorites()
        let isPostFavorited = sut.isPostFavorited(sut.post!)
        XCTAssertTrue(isPostFavorited, "Post was NOT Favorited")
        
    }
    
    func testRemoveFromFavorites() {
        sut.removeFromFavorites()
        let isPostFavorited = sut.isPostFavorited(sut.post!)
        XCTAssertFalse(isPostFavorited, "Post was NOT removed from faves")
    }

}

//
//  UserManagerTests.swift
//  MavenBlogTests
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

@testable import MavenBlog
import XCTest

class UserManagerTests: XCTestCase {
    
    var sut: UserManager!
    var post: Post!
    
    override func setUpWithError() throws {
        sut = UserManager.shared
        post = Post()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        post = nil
    }
    
    func testLoginSuccess() {
        let expectation = XCTestExpectation(description: "LoggedIN")
        sut.logIn(username: "user", password: "pass") { (error) in
            if error == nil {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 6.0)
        XCTAssertTrue(sut.isLoggedIn, "user not logged in")
        
    }
    
    func testLoginFailure() {
        let expectation = XCTestExpectation(description: "LoggedOUT")
        sut.logIn(username: "user", password: "psss") { (error) in
            if let _ = error {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 6.0)
        XCTAssertNil(sut.currentUser, "User not nil")
        
    }
    
    func testAddToFavorites() {
        sut.userDidFavoritePost(post)
        XCTAssertEqual(sut.favoritePosts.count, 1)
        
    }
    
    func testResetFavorites() {
        sut.userDidFavoritePost(post)
        sut.userDidFavoritePost(post)
         XCTAssertEqual(sut.favoritePosts.count, 2)
        sut.resetFavoritePost()
        XCTAssertEqual(sut.favoritePosts.count, 0)
        
        
        
    }
}

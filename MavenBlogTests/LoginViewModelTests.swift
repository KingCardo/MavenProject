//
//  LoginViewModelTests.swift
//  MavenBlogTests
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

@testable import MavenBlog
import XCTest


class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModel!

    override func setUpWithError() throws {
        sut = LoginViewModel()
    }

    override func tearDownWithError() throws {
       sut = nil
    }
    
    func testSubmitCredentialsCompletionCalled() {
        var called = false
        
        sut.submitCredentials(username: "user", password: "pass") { (error) in
            called = true
            XCTAssertTrue(called, "Completion wasn't called")
        }
    }

}

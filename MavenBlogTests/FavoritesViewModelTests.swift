//
//  FavoritesViewModelTests.swift
//  MavenBlogTests
//
//  Created by Riccardo Washington on 7/23/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

@testable import MavenBlog
import XCTest

class FavoritesViewModelTests: XCTestCase {

    var sut: FavoritesViewModel!
    
    override func setUpWithError() throws {
        sut = FavoritesViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

}

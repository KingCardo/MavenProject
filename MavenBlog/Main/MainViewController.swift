//
//  MainViewController.swift
//  MavenBlog
//
//  Created by Riccardo Washington on 7/22/20.
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private var blogListNavigationController: UINavigationController!
    private var favoriteNavigationController: UINavigationController!
    
    private func setup() {
        
        let blogListViewController = BlogPostListViewController()
        blogListNavigationController = UINavigationController(rootViewController: blogListViewController)
        blogListNavigationController.tabBarItem = UITabBarItem(title: "Posts", image: nil, selectedImage: nil)
        
        let favoriteViewController = FavoritesViewController()
        favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "Faves", image: nil, selectedImage: nil)
        
        setViewControllers([blogListNavigationController, favoriteNavigationController], animated: true)
    }
}

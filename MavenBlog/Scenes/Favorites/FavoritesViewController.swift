//
//  FavoritesViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var favoritesViewModel = FavoritesViewModel()
    
    private var favoriteCount: Int {
        return favoritesViewModel.posts.count
    }
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoritesCell")
        tableView.backgroundColor = .white
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        tableView.reloadData()
        registerObservers()
        
    }
    
    // MARK: - Methods
    
    @objc func favoritedPostsDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.title = "Faves (\(String(describing: self?.favoriteCount)))"
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setupNavigationBar() {
           navigationItem.title = "Faves (\(favoriteCount))"
           
       }
    
    private func setupViews() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func registerObservers() {
         NotificationCenter.default.addObserver(self, selector: #selector(favoritedPostsDidChange), name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification), object: nil)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath)
        cell.textLabel?.text = favoritesViewModel.posts[indexPath.row].title
        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailViewController = BlogPostDetailViewController()
        let post = favoritesViewModel.posts[indexPath.row]
        postDetailViewController.blogDetailViewModel.post = post
        postDetailViewController.showsFaveButton = false
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
}

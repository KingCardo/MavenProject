//
//  BlogPostListViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class BlogPostListViewController: UIViewController, LogInViewControllerDelegate {
    
    private var blogPostViewModel = BlogPostViewModel()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Lifceycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        registerNotifications()
        setupTableView()
        validateUser()
    }
    
    // MARK: - Methods
    
    func logInViewControllerDidLogIn() {
        navigationItem.title = "Welcome, \(String(describing: UserManager.shared.userName))!"
        
        blogPostViewModel.login() { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    let ac = UIAlertController.createAlert(title: "Error", message: "\(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self?.present(ac, animated: true, completion: nil)
                        return
                    }
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritedPostsDidChange), name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification), object: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
    }
    
    private func validateUser() {
        if UserManager.shared.userName == nil {
            navigateToLogIn()
        }
    }
    
    @objc func favoritedPostsDidChange() {
        tableView.reloadData()
    }
    
    @objc func logOut() {
        blogPostViewModel.logOut()
        
        tabBarController?.tabBar.items?[1].badgeValue = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification),
                                        object: nil)
        navigateToLogIn()
    }
    
    private func navigateToLogIn() {
        let loginViewController = LogInViewController()
        loginViewController.modalPresentationStyle = .overFullScreen
        loginViewController.delegate = self
        navigationController?.present(loginViewController, animated: true, completion: nil)
    }
    
    private func isPostFavorited(_ post: Post) -> Bool {
        return blogPostViewModel.isPostFavorited(post)
    }
}

extension BlogPostListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPostViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = blogPostViewModel.posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.backgroundColor = isPostFavorited(post) ? .yellow : .white
        return cell
    }
}

extension BlogPostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailViewController = BlogPostDetailViewController()
        let post = blogPostViewModel.posts[indexPath.row]
        postDetailViewController.blogDetailViewModel.post = post
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
}

//
//  BlogPostListViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class BlogPostListViewController: UIViewController, LogInViewControllerDelegate {
    
    private var blogPostViewModel = BlogPostViewModel(service: /* AlamoFire()*/Networking())
    
    private static let bpTableViewCellID = "BlogTableViewCellID"
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: BlogPostListViewController.bpTableViewCellID)
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
        
        guard let username = UserManager.shared.userName else { return }
        navigationItem.title = "Welcome, \(String(describing: username))!"
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
        if !UserManager.shared.isLoggedIn {
            navigateToLogIn()
        } else {
            logInViewControllerDidLogIn()
        }
    }
    
    @objc private func favoritedPostsDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    @objc private func logOut() {
        let ac = UIAlertController.createAlert(title: "Log Out?", message: "Are you sure you want to log out?") { [weak self] _ in
            
            self?.blogPostViewModel.logOut()
            
            self?.tabBarController?.tabBar.items?[1].badgeValue = nil
            NotificationCenter.default.post(name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification),
                                            object: nil)
            self?.navigateToLogIn()
        }
        
        present(ac, animated: true)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: BlogPostListViewController.bpTableViewCellID, for: indexPath)
        let post = blogPostViewModel.posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.backgroundColor = isPostFavorited(post) ? .yellow : .white
        return cell
    }
}

extension BlogPostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postDetailViewController = BlogPostDetailViewController()
        let post = blogPostViewModel.posts[indexPath.row]
        postDetailViewController.blogDetailViewModel.post = post
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
}

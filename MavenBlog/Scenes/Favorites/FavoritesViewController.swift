//
//  FavoritesViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [Post] {
        return UserManager.shared.usersFavoritePosts
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Faves (\(posts.count))"
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoritedPostsDidChange), name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification), object: nil)
    }
    
    @objc func favoritedPostsDidChange() {
        navigationItem.title = "Faves (\(posts.count))"
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlogPostDetailViewController") as! BlogPostDetailViewController
        let post = posts[indexPath.row]
        postDetailViewController.post = post
        postDetailViewController.showsFaveButton = false
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
}

//
//  BlogPostListViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class BlogPostListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LogInViewControllerDelegate {
    
    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoritedPostsDidChange), name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification), object: nil)
        
        if UserManager.shared.currentUser == nil {
            navigateToLogIn()
        }
    }
    
    func logInViewControllerDidLogIn() {
        navigationItem.title = "Welcome, \(UserManager.shared.currentUser!.username)!"

        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts")!, completionHandler: { [weak self] data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
                let posts = (jsonArray ?? []).compactMap({ json -> Post? in
                  return Post(json: json)
                })
                self?.posts = posts
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }).resume()
    }
    
    @objc func favoritedPostsDidChange() {
        tableView.reloadData()
    }
    
    @objc func logOut() {
        UserManager.shared.currentUser = nil
        UserManager.shared.usersFavoritePosts = []
        tabBarController?.tabBar.items?[1].badgeValue = nil
        NotificationCenter.default.post(name: Notification.Name(rawValue: UserManager.FavoritesChangedNotification),
                                        object: nil)
        navigateToLogIn()
    }
    
    func navigateToLogIn() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        loginViewController.modalPresentationStyle = .overFullScreen
        loginViewController.delegate = self
        navigationController?.present(loginViewController, animated: true, completion: nil)
    }
    
    func isPostFavorited(_ post: Post) -> Bool {
        return UserManager.shared.usersFavoritePosts.map { $0.id }.contains(post.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.backgroundColor = isPostFavorited(post) ? .yellow : .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlogPostDetailViewController") as! BlogPostDetailViewController
        let post = posts[indexPath.row]
        postDetailViewController.post = post
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
}

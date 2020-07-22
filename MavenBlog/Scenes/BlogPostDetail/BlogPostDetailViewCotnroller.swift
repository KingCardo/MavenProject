//
//  BlogPostDetailViewCotnroller.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

class BlogPostDetailViewController: UIViewController {
    
    var showsFaveButton: Bool = true
    var isFavorited: Bool = false
    var blogDetailViewModel = BlogListDetailViewModel(service: Networking())
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 2
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        isFavorited = isPostFavorited(blogDetailViewModel.post)
        updateUI()
        start()
       
    }
    
    // MARK: - Methods
    
    private func start() {
        blogDetailViewModel.start() { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    
                    self?.titleLabel.text = error.localizedDescription
                    return
                    
                } else {
                    self?.updateUI()
                }
            }
        }
    }
    
    private func setupContainerStack() {
        view.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    
    private func updateViews() {
        
    }
    
    private func isPostFavorited(_ post: Post) -> Bool {
        return blogDetailViewModel.isPostFavorited(post)
    }
    
    private func updateUI() {
        self.titleLabel.text = blogDetailViewModel.post.title
        self.bodyLabel.text = blogDetailViewModel.post.body
        
        if showsFaveButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: (isFavorited ? "Unfave" : "Fave"),
                style: .done,
                target: self,
                action: (isFavorited ? #selector(removeFromFavorites) : #selector(addToFavorites)))
        }
        
        // Update Favorites tab bar badges
        let numFavoritedPosts = UserManager.shared.favoritePosts.count
        tabBarController?.tabBar.items?[1].badgeValue = numFavoritedPosts == 0 ? nil : String(numFavoritedPosts)
    }
    
    @objc private func addToFavorites() {
        isFavorited = true
        blogDetailViewModel.addToFavorites()
        updateUI()
    }
    
    @objc private func removeFromFavorites() {
        isFavorited = false
        blogDetailViewModel.removeFromFavorites()
        updateUI()
    }
    
    private func setupViews() {
        title = "Post \(blogDetailViewModel.post.id)"
        setupContainerStack()
        view.backgroundColor = .white
        
    }
    
}

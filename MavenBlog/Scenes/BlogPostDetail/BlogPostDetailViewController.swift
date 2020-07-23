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
        label.font = UIFont.makeTitleFont(size: BlogPostDetailViewController.titleLabelFontSize)
        label.numberOfLines = BlogPostDetailViewController.titleLabelNumberOfLines
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.makeAvenirNext(size: BlogPostDetailViewController.bodyLabelFontSize)
        label.numberOfLines = BlogPostDetailViewController.bodyLabelNumberOfLines
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = BlogPostDetailViewController.containerSpacing
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        if let post = blogDetailViewModel.post {
        isFavorited = isPostFavorited(post)
        }
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
        containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BlogPostDetailViewController.containerDimensions.left).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: BlogPostDetailViewController.containerDimensions.right).isActive = true
        
    }
    
    private func isPostFavorited(_ post: Post) -> Bool {
        return blogDetailViewModel.isPostFavorited(post)
    }
    
    private func updateUI() {
        guard let post = blogDetailViewModel.post else { return }
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
        
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
        guard let post = blogDetailViewModel.post else { return }
        title = "Post \(post.id)"
        setupContainerStack()
        view.backgroundColor = .white
        
    }
}

extension BlogPostDetailViewController {
    static let containerSpacing: CGFloat = 25
    static let containerDimensions = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
    static let bodyLabelFontSize: CGFloat = 16
    static let bodyLabelNumberOfLines = 0
    static let titleLabelFontSize: CGFloat = 32
    static let titleLabelNumberOfLines = 2
}

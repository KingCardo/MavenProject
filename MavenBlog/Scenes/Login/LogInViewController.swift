//
//  LogInViewController.swift
//  MavenBlog
//
//  Copyright © 2020 Maven Clinic. All rights reserved.
//

import UIKit

protocol LogInViewControllerDelegate: class {
    func logInViewControllerDidLogIn()
}

class LogInViewController: UIViewController {
    
    weak var delegate: LogInViewControllerDelegate?
    
    // MARK: - Views
    
    private let mavenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Maven Blog"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 37)//TODO: - refactor
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.minimumFontSize = 17
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.minimumFontSize = 17
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchDown)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, submitButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mavenTitleLabel, containerStack])
        stackView.axis = .vertical
        stackView.spacing = 75
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Methods
    
    @objc func submitButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields.", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        UserManager.shared.logIn(username: username, password: password) { [weak self] error in
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    return
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.delegate?.logInViewControllerDidLogIn()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Setup Views
    
    private func setupViewBackgroundColor() {
        view.backgroundColor = UIColor.mavenBackgroundGreen
    }
    
    private func setupMainStack() {
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
//    private func setupMavenTitleLabel() {
//        view.addSubview(mavenTitleLabel)
//        mavenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        mavenTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        mavenTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LogInViewController.mavenLabelTopAnchorSpacing).isActive = true
//
//    }
    
    //private func
    
    private func setupViews() {
        setupViewBackgroundColor()
        setupMainStack()
    }
}

extension LogInViewController {
    static let mavenLabelTopAnchorSpacing: CGFloat = 100
}

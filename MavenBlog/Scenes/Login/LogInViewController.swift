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
    
    private var loginViewModel = LoginViewModel()
    
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
        tf.minimumFontSize = LogInViewController.minFontSize
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.minimumFontSize = LogInViewController.minFontSize
        tf.adjustsFontSizeToFitWidth = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = UIColor.mavenDarkGreen
        button.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchDown)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: LogInViewController.submitButtonSize.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: LogInViewController.submitButtonSize.height).isActive = true
        return button
    }()
    
    private lazy var containerSubmitButton: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, containerSubmitButton])
        stackView.axis = .vertical
        stackView.spacing = LogInViewController.containerStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mavenTitleLabel, containerStack])
        stackView.axis = .vertical
        stackView.spacing = LogInViewController.mainStackViewSpacing
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Methods
    
    @objc func submitButtonTapped(_ sender: UIButton) {
        print("tapped")
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController.createAlert(title: "Error", message: "Please fill out all fields.")
            present(alert, animated: true, completion: nil)
            return
        }
        
        loginViewModel.submitCredentials(username: username, password: password) { [weak self] error in
            
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController.createAlert(title: "Error", message: "\(error.localizedDescription)")
                    self?.present(alert, animated: true, completion: nil)
                    return
                }
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
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LogInViewController.mainStackDimensions.top).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LogInViewController.mainStackDimensions.left).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LogInViewController.mainStackDimensions.right).isActive = true
    }
    
    private func setupSubmitButton() {
        containerSubmitButton.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: containerSubmitButton.centerXAnchor).isActive = true
    }
    
    private func setupViews() {
        setupViewBackgroundColor()
        setupMainStack()
        setupSubmitButton()
        
    }
}

extension LogInViewController {
    static let mavenLabelTopAnchorSpacing: CGFloat = 100
    static let mainStackDimensions = UIEdgeInsets(top: 100, left: 32, bottom: 0, right: -32)
    static let minFontSize: CGFloat = 17
    static let submitButtonSize = CGSize(width: 100, height: 44)
    static let mainStackViewSpacing: CGFloat = 75
    static let containerStackViewSpacing: CGFloat = 25
}

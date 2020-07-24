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
    
    private let mavenTitleLabel = UILabel.createLabel(text: "Maven Blog", font: UIFont.makeTitleFont(size: LogInViewController.titleLabelFontSize))
    
    private let usernameTextField = UITextField.createTextField(minimumFontSize: LogInViewController.minFontSize,
                                                                font: UIFont.systemFont(ofSize: LogInViewController.textFieldFontSize),
                                                                placeHolder: "Username")
    
    private let passwordTextField = UITextField.createTextField(minimumFontSize: LogInViewController.minFontSize,
                                                                font: UIFont.systemFont(ofSize: LogInViewController.textFieldFontSize),
                                                                placeHolder: "Password", isSecureTextEntry: true)
    
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.makeAvenirNext(size: LogInViewController.submitButtonFontSize)
        button.backgroundColor = UIColor.mavenDarkGreen
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: LogInViewController.submitButtonSize.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: LogInViewController.submitButtonSize.height).isActive = true
        button.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchDown)
        return button
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
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
    
    private lazy var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: LogInViewController.spinnerSpacingTop).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.startAnimating()
    }
    
    private func removeSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Methods
    
    @objc private func submitButtonTapped(_ sender: UIButton) {
        setupSpinner()
        
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController.createAlert(title: "Error", message: "Please fill out all fields.")
            present(alert, animated: true, completion: nil)
            removeSpinner()
            return
        }
        
        loginViewModel.submitCredentials(username: username, password: password) { [weak self] error in
            
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController.createAlert(title: "Error", message: "\(error.localizedDescription)")
                    self?.present(alert, animated: true, completion: nil)
                    self?.removeSpinner()
                    return
                }
                return
            }
            DispatchQueue.main.async {
                self?.delegate?.logInViewControllerDidLogIn()
                self?.removeSpinner()
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
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: LogInViewController.submitButtomTopSpacing).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    static let submitButtomTopSpacing: CGFloat = 25
    static let titleLabelFontSize: CGFloat = 37
    static let textFieldFontSize: CGFloat = 14
    static let submitButtonFontSize: CGFloat = 15
    static let spinnerSpacingTop: CGFloat = 25
}

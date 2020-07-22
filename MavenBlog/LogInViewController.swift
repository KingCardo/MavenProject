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

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 220/255, green: 233/255, blue: 226/255, alpha: 1)
        submitButton.backgroundColor = UIColor(red: 0/255, green: 133/255, blue: 111/255, alpha: 1)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
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
    
}

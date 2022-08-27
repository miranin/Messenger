//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 16.08.2022.
//

import UIKit

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class LoginViewController: UIViewController {
    
    private var loginViewModel = LoginViewModel()
    
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        
        return InputContainerView(imageSF: UIImage(named: "imageEnvelope"), textField: emailTextField)
        
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(imageSF: UIImage(named: "imageLock"), textField: passwordTextField)
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .secondaryLabel
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16),                                                                                                .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Sign up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                                                  .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField = CustomTextField(placehodler: "Email")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placehodler: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
        
        
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSignUp() {
        let controller = RegistrationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChanged(sender: UITextField) {
        if sender == emailTextField {
            loginViewModel.email = sender.text
        }else {
            loginViewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        print("DEBUG: Login Here..")
    }
    
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32,  paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 32,
                                     paddingRight: 32)
        
        
     
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged ), for: .editingChanged)

    }
            
    
}

extension LoginViewController: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if loginViewModel.isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .secondaryLabel
        }
    }
}

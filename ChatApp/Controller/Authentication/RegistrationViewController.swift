//
//  RegistrationViewController.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 16.08.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationViewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
        
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(imageSF: UIImage(named: "imageEnvelope"), textField: emailTextField)
    }()
    
    private lazy var fullNameContainerView: InputContainerView = {
        return InputContainerView(imageSF: UIImage(named: "imagePerson"), textField: fullNameTextField)
    }()
    
    private lazy var usernameContainerView: InputContainerView = {
        return InputContainerView(imageSF: UIImage(named: "imagePerson"), textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(imageSF: UIImage(named: "imageLock"), textField: passwordTextField)
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .secondaryLabel
        button.setHeight(height: 50)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16),                                                                                                .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                                                 .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField = CustomTextField(placehodler: "Email")
    
    private let fullNameTextField = CustomTextField(placehodler: "Full Name")
    
    private let usernameTextField = CustomTextField(placehodler: "Username")
    
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
    
    @objc func handleSelectPhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    @objc func handleLogIn() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleSignUp() {
        
        print("DEBUG: Sign Up here..")
    }
    
    
    @objc func textDidChanged(sender: UITextField) {
        
        if sender == emailTextField {
            registrationViewModel.email = sender.text
        }else if sender == passwordTextField {
            registrationViewModel.password = sender.text
        }else if sender == fullNameTextField {
            registrationViewModel.fullname = sender.text
        }else{
            registrationViewModel.username = sender.text
        }
        
        checkFormStatus()
        
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   fullNameContainerView,
                                                   usernameContainerView,
                                                   passwordContainerView,
                                                   signUpButton,
                                                   alreadyHaveAccountButton])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 32,
                                        paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
    
    
}

// MARK: - UIImagePickerControllerDelegate



extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController: AuthenticationControllerProtocol {
    
    func checkFormStatus() {
        if registrationViewModel.isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .systemPink
        }else{
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .secondaryLabel
        }
    }
}


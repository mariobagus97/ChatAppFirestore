//
//  RegistrationViewController.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 18/01/21.
//


import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    // MARK: - PROPERTIES
    
    private var viewModel = RegisterViewModel()
    private var profileImage : UIImage?
    
    private let uploadPhotoButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.tintColor = UIColor.white
        btn.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        btn.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFill 
        return btn
    }()
    
    private lazy var emailContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textfield: emailTextField)
    private lazy var fullnameContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: fullnameTextField)
    private lazy var usernameContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: usernameTextField)
    private lazy var passwordContainerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x") , textfield: passwordTextField)
    
    private let signupButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setHeight(height: 50)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    private let emailTextField = CustomTextField(Placeholder: "Email")
    private let fullnameTextField = CustomTextField(Placeholder: "Full Name")
    private let usernameTextField = CustomTextField(Placeholder: "Username")
    private let passwordTextField : CustomTextField = {
        let tf = CustomTextField(Placeholder: "Password")
        tf.isSecureTextEntry =  true
        return tf
    }()
    
    private let loginButton : UIButton = {
        let btn = UIButton(type: .system)
        let attributeTittle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor.white])
        attributeTittle.append(NSAttributedString(string: "Log In", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor : UIColor.white]))
        btn.setAttributedTitle(attributeTittle, for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Selector
    @objc func uploadPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide(){
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let profileimage = profileImage else { return }
        
        showLoader(true, withText: "Create User ....")
        
        AuthService.shared.createUser(credential: RegistrationCredentials(Email: email, Password: password, Username: username, Fullname: fullname, ProfileImage: profileimage)) { (error) in
            if let error = error{
                print("DEBUG: Failed create user with error \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
        configureNotificationObserver()
    }
    
    // MARK: - Helpers
    func ConfigureUI() {
        configureGradientLayer()
        
        view.addSubview(uploadPhotoButton)
        uploadPhotoButton.centerX(inView: view)
        uploadPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        uploadPhotoButton.setDimensions(height: 200, width: 200)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView, usernameContainerView, passwordContainerView, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.anchor(top: uploadPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(loginButton)
        loginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        
    }
    
    func configureNotificationObserver() {
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
    
}
// MARK: - UIImagePickerControllerDelegate
    
extension RegistrationViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        profileImage = image
        uploadPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        uploadPhotoButton.layer.borderColor = UIColor.white.cgColor
        uploadPhotoButton.layer.borderWidth = 3.0
        uploadPhotoButton.layer.cornerRadius = 200 / 2
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController :IAuthenticationVc {
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}

//
//  LoginViewController.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 18/01/21.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - PROPERTIES
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textfield: emailTextField)
    }()
    
    private lazy var passwordContainerView : InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x") , textfield: passwordTextField)
    }()
    
    private let loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log in", for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.setHeight(height: 50)
        return btn
    }()
    
    private let emailTextField = CustomTextField(Placeholder: "Email")
    
    private let passwordTextField : CustomTextField = {
        let tf = CustomTextField(Placeholder: "Password")
        tf.isSecureTextEntry =  true
        return tf
    }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton(type: .system)
        let attributeTittle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor.white])
        attributeTittle.append(NSAttributedString(string: "Sign Up", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor : UIColor.white]))
        btn.setAttributedTitle(attributeTittle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowSignUp(){
        print("Sign up view showing....")
    }
    
    // MARK: - Helpers
    
    func ConfigureUI() {
        view.backgroundColor = .systemPurple
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        ConfigureGradientLayer()
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func ConfigureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor , UIColor.systemPink.cgColor]
        gradient.locations =  [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}

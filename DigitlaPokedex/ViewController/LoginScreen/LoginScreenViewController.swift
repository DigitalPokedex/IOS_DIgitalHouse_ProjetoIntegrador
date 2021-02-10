//
//  LoginScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit


class LoginScreenViewController: UIViewController {

    let viewModel = LoginScreenViewModel()
    
    @IBOutlet weak var lugiaImage: UIImageView!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        viewModel.setupNavigationController(navigationController: self.navigationController, screen: self)
        
        //Google settings
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        viewModel.googleLogin()
        
        //Facebook settings
        facebookLoginButton.permissions = ["public_profile", "email"]
        facebookLoginButton.delegate = self
        viewModel.facebookLogin()
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupUI()
    }
    
    
    func configureTextField(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 15
    }
    
    func configureImage() {
        view.addSubview(lugiaImage)
        let screenHeight = ScreenSettings.screenHeight
        let screenWidth = ScreenSettings.screenWidth
        let imageSize = screenHeight * 0.2586 <= 210 ? screenHeight * 0.2586 : CGFloat(210)
        let loginContainerHeight = CGFloat(446)
        if imageSize < 210 {
            lugiaImage.frame = CGRect(x: (screenWidth - imageSize)  / 2, y: screenHeight - 20 - loginContainerHeight - imageSize, width: imageSize, height: imageSize)
        }
    }
    
    func configureContainer() {
        loginContainer.layer.cornerRadius = 35
        loginContainer.backgroundColor = Colors.grey
        loginContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginContainer.layer.masksToBounds = true
    }
    
    func setupUI() {
        configureTextField(textField: self.emailInput)
        configureTextField(textField: self.passwordInput)
        
        configureImage()
        configureContainer()
        
        loginButton.layer.cornerRadius = 15
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        viewModel.toPreviousScreen()
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel.loginButtonAction(email: emailInput.text!, password: passwordInput.text!)
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
        viewModel.toSignUpScreen()
    }
    
    @objc func didSignIn()  {
        viewModel.googleLogin()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
extension LoginScreenViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        viewModel.facebookLogin()
    }
}

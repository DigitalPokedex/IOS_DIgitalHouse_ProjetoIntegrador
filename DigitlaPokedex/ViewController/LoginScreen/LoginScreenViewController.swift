//
//  LoginScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit

class LoginScreenViewController: UIViewController {

    let viewModel = LoginScreenViewModel()
    
    @IBOutlet weak var lugiaImage: UIImageView!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewModel.setupNavigationController(navigationController: self.navigationController)
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
        viewModel.toLoginScreen()
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
        viewModel.toSignUpScreen()
    }
}

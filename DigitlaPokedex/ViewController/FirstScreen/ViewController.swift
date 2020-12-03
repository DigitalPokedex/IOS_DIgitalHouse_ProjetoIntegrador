//
//  FirstScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let viewModel = FirstScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        setupUI()

        
    }
    // Todo: Colocar em um método estático da SignupViewModel
    @IBAction func loginAction(_ sender: Any) {
        viewModel.toLoginScreen(navigationController: self.navigationController)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        viewModel.toSignUpScreen(navigationController: self.navigationController)
    }
    
    func setupUI() {
        containerView.layer.cornerRadius = 35
        containerView.backgroundColor = Colors.grey
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        
        loginButton?.layer.cornerRadius = 10
        signupButton?.layer.cornerRadius = 10
        signupButton?.layer.borderWidth = 1.5
        signupButton?.layer.borderColor = Colors.primary.cgColor
        signupButton.backgroundColor = .white
    }
}

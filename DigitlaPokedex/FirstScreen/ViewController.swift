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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

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
    @IBAction func loginAction(_ sender: Any) {
        let loginViewController = UIStoryboard(name: "LoginScreen", bundle: nil).instantiateInitialViewController() as! LoginScreenViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    @IBAction func signUpAction(_ sender: Any) {
        let signUpViewController = UIStoryboard(name: "SignUpScreen", bundle: nil).instantiateInitialViewController() as! SignUpScreenViewController
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

//
//  LoginScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit

class LoginScreenViewModel {
    private var navigationController: UINavigationController!
    
    func setupNavigationController(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func toPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func toSignUpScreen() {
        let signUpViewController = UIStoryboard(name: "SignUpScreen", bundle: nil).instantiateInitialViewController() as! SignUpScreenViewController
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func toLoginScreen() {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
}

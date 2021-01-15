//
//  LoginScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit
import Firebase

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
    
    func toHomeScreen() {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
    
    func loginButtonAction(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          if((authResult != nil) && error == nil) {
              strongSelf.toHomeScreen()
          }
        }
    }
}

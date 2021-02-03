//
//  LoginScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class LoginScreenViewModel {
    private var navigationController: UINavigationController!
    var loginScreen: LoginScreenViewController!
    
    func setupNavigationController(navigationController: UINavigationController!, loginScreen: LoginScreenViewController!) {
        self.navigationController = navigationController
        self.loginScreen = loginScreen
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
    
    func showAlert() {
        let alert = UIAlertController(title: "Atenção",
                                      message: "Escolha a opção",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Coxinha", style: .default, handler: { (action) in
            print("Coxinha")
        }))
        alert.addAction(UIAlertAction(title: "Kibe", style: .default, handler: { (action) in
            print("Kibe")
        }))
        loginScreen.present(alert, animated: true, completion: nil)
    }
    
    func isConnected() -> Bool {
        let isConnected = Reachability.isConnectedToNetwork()
        //if(isConnected) { showAlert() }
        showAlert()
        return false
        //return !isConnected
    }
    
    func loginButtonAction(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if((authResult != nil) && error == nil) {
                strongSelf.toHomeScreen()
            }
        }
    }
    
    func googleLogin() {
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            toHomeScreen()
        }
    }
    
    func facebookLogin(){
        if let token = AccessToken.current, !token.isExpired {
            toHomeScreen()
        }
    }
       
}

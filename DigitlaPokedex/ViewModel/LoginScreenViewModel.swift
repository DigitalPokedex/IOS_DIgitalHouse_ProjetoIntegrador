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
    var screen: LoginScreenViewController!
    
    func isConnected() -> Bool {
        let isConnected = Reachability.isConnectedToNetwork()
        if(!isConnected) { showAlert(isConnectionAlert: true) }
        
        return isConnected
    }
    
    func setupNavigationController(navigationController: UINavigationController!, screen: LoginScreenViewController!) {
        self.navigationController = navigationController
        self.screen = screen
        
        self.isConnected()
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
    
    func showAlert(isConnectionAlert: Bool) {
        let title = isConnectionAlert ? "No internet connection!" : "Invalid email or password"
        let message = isConnectionAlert ? "Please check your network settings and try again." : "Please, try again."
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            if (isConnectionAlert) { self.toPreviousScreen() }
        }))
        screen.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmailAndPassword(_ email: String, _ password: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let isInvalidEmail = email == "" || !emailPred.evaluate(with: email)
        let isInvalidPassword = password == "" || password.count < 6
        
        if(isInvalidEmail || isInvalidPassword) {
            showAlert(isConnectionAlert: false)
            return false
        }
        
        return true
    }
    
    func saveUser() {
        let firebaseUser = Auth.auth().currentUser
        let defaults = UserDefaults.standard
        if let firebaseUser = firebaseUser {
            defaults.setValue(firebaseUser.uid, forKey: "savedUserId")
        }
    }
    
    func loginButtonAction(email: String, password: String) {
        if(isConnected() && isValidEmailAndPassword(email, password)) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if((authResult != nil) && error == nil) {
                    strongSelf.toHomeScreen()
                    self?.saveUser()
                } else {
                    self?.showAlert(isConnectionAlert: false)
                }
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

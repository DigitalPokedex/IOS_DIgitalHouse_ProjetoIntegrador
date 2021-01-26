//
//  SignUpScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit
import Firebase

class SignUpScreenViewModel {
    private var navigationController: UINavigationController!

    func setupNavigationController(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func toInitialFavoritesRegistrationScreen() {
        let viewController = UIStoryboard(name: "InitialFavoritesRegistration", bundle: nil).instantiateInitialViewController() as! InitialFavoritesRegistrationViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func toPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func saveButtonAction(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if((authResult != nil) && error == nil) {
                self.toInitialFavoritesRegistrationScreen()
            }
            else {
                print(authResult, error)
            }
        }
    }
    
}

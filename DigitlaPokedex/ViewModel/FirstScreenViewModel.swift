//
//  FirstScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 27/11/20.
//

import Foundation
import UIKit

class FirstScreenViewModel {
    
    
    func toLoginScreen(navigationController: UINavigationController?) {
        let loginViewController = UIStoryboard(name: "LoginScreen", bundle: nil).instantiateInitialViewController() as! LoginScreenViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func toSignUpScreen(navigationController: UINavigationController?) {
        let signUpViewController = UIStoryboard(name: "SignUpScreen", bundle: nil).instantiateInitialViewController() as! SignUpScreenViewController
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}

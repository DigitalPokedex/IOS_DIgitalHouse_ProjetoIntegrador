//
//  ProfileViewModel.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 04/02/21.
//

import Foundation
import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn


class ProfileViewModel {
    
    private var navigationController: UINavigationController!

    func setupNavigationController(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func logOutConnections() {
        let firebaseAuth = Auth.auth()
        do {
            //Facebook Logout
            let loginManager = LoginManager()
            loginManager.logOut()
            //Google Logout
            GIDSignIn.sharedInstance().signOut()
            //Firebase Logout
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

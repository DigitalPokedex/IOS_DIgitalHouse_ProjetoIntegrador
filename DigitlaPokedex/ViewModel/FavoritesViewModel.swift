//
//  FavoritesViewModel.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 29/01/21.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class FavoritesViewModel {
    
    
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

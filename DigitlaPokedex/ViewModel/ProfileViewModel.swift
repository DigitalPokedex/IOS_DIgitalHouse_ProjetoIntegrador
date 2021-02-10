//
//  ProfileViewModel.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 04/02/21.
//

import Foundation
import UIKit
import Firebase
import Realm
import RealmSwift
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
    
    func clearSavedUser() {
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: "savedUserId")
    }
    
    func changeRootViewController() {
        let nav = UIStoryboard(name: "FirstScreen", bundle: nil).instantiateInitialViewController() as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func removeAllFavorites() {
        let favoritesList = returnFavorites()
        
        for favorite in favoritesList {
            removeFavorite(withId: favorite.id.value!)
        }
        
    }
    
    func returnFavorites() -> List<CompletePokemonRealm> {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        return dataRealm.count > 0 ? dataRealm[0].favorites : List<CompletePokemonRealm>()
    }
    
    func removeFavorite(withId: Int) {
        let realm = try! Realm()
        try! realm.write {
            let dataRealm = realm.objects(DataRealm.self)
            let objectsToDelete = realm.objects(CompletePokemonRealm.self).filter("id == \(withId)")
            realm.delete(objectsToDelete)
        }
    }
    
    func setupLogout() {
        removeAllFavorites()
        clearSavedUser()
        changeRootViewController()
        TabBarController.shared.selectedIndex = 0
    }
}

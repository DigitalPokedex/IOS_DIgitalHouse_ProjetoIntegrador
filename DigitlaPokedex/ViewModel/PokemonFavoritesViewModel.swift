//
//  PokemonFavoritesViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 22/01/21.
//
//
//  InitialFavoritesRegistrationViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll
import Realm
import RealmSwift
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class PokemonFavoritesViewModel {
    private var navigationController: UINavigationController!
    var collectionView: UICollectionView!
    var pokemonAPI = PokemonAPI()
    
    func verifyFavorites() {
        
        let firebaseUser = Auth.auth().currentUser
        let defaults = UserDefaults.standard
        let savedUserId = defaults.object(forKey:"savedUserId") as? String ?? ""
        if let firebaseUser = firebaseUser {
            
            defaults.setValue(firebaseUser.uid, forKey: "savedUserId")
            removeAllFavorites()
            updateFavoritesList(withId: firebaseUser.uid)
        }
    }
    
    func saveDataOnRealm(favoritesList: [Pokemon]) {
        let realm = try! Realm()
        try! realm.write {
            for favorite in favoritesList {
                let convertedPokemon = CompletePokemonRealm.convertPokemonToRealm(original: favorite)
                let dataRealm = realm.objects(DataRealm.self)
                dataRealm[0].favorites.append(convertedPokemon)
                
            }
            
            self.collectionView.reloadData()
        }
    }
    
    func updateFavoritesList(withId: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child(withId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let favorites = value?["favorites"] as? [String: Any]
            self.collectionView.reloadData()
            if let favorites = favorites {
                
                self.pokemonAPI.getFavoritesList(ids: favorites) { (favoritesList, success) in
                    if(favoritesList != nil) {
                        if let favoritesList = favoritesList {
                            self.saveDataOnRealm(favoritesList: favoritesList)
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
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
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func configureViewModel(navigationController: UINavigationController!, collectionView: UICollectionView!) {
        self.navigationController = navigationController
        self.collectionView = collectionView
    }
    
    func isFavorite(element: Pokemon) -> Bool {
        let results = returnFavorites().filter("id == \(element.id!)")
        return results.count > 0
    }
    
    func sortElementsById(_ list: [AnyObject]) -> [AnyObject] {
        let sortedElements = list.sorted {
            $0.id < $1.id
        }
        return sortedElements
    }
    
    
    func getNumberOfCells(collectionView: UICollectionView) -> Int {
        
        return returnFavorites().count
    }
    
    
    func getCustomCollectionCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAndFavoriteCollectionViewCell", for: indexPath) as! HomeAndFavoriteCollectionViewCell
        cell.setup(pokemon: returnFavorites()[indexPath.row])
        return cell
    }
    
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

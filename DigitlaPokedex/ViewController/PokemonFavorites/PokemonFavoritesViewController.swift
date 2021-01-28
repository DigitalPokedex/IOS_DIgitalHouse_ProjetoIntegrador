//
//  PokemonFavoritesViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit
import Firebase

class PokemonFavoritesViewController: UIViewController {
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var collectionViewPokemon: UICollectionView!
    
    var viewModel = PokemonFavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewLogo.image = UIImage(named: "Logo")
        self.hideKeyboardWhenTappedAround()
        
        collectionViewPokemon.delegate = self
        collectionViewPokemon.dataSource = self
        
        let nib = UINib(nibName: "HomeAndFavoriteCollectionViewCell", bundle: nil)
        self.collectionViewPokemon.register(nib, forCellWithReuseIdentifier: "HomeAndFavoriteCollectionViewCell")
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
        //viewModel.toPreviousScreen()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

extension PokemonFavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailView = PokemonDetailViewController.getPokemonDetails() {
            /*detailView.image = controller.arrayPokemons[indexPath.row].image
            detailView.name = controller.arrayPokemons[indexPath.row].name
            detailView.pokemonDescription = controller.arrayPokemons[indexPath.row].type
            detailView.hp = String(controller.arrayPokemons[indexPath.row].hp)
            detailView.atk = String(controller.arrayPokemons[indexPath.row].atk)
            detailView.def = String(controller.arrayPokemons[indexPath.row].def)
            detailView.stak = String(controller.arrayPokemons[indexPath.row].stak)
            detailView.sdef = String(controller.arrayPokemons[indexPath.row].sdef)
            detailView.spd = String(controller.arrayPokemons[indexPath.row].spd)*/
            present(detailView, animated: true, completion: nil)
        }
    }
}

extension PokemonFavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfCells(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.getCustomCollectionCell(collectionView: collectionView, indexPath: indexPath)
        
        return cell
    }
}

extension PokemonFavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = ScreenSettings.screenWidth
        let cellWidth = ((screenWidth - 35) / 2)
        return CGSize(width: cellWidth, height: 80)
    }
}

//
//  PokemonFavoritesViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit

class PokemonFavoritesViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var collectionViewPokemon: UICollectionView!
    var controller = PokemonController()
    
    var pokemonFiltred = [PokemonTemp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewLogo.image = UIImage(named: "Logo")
        self.hideKeyboardWhenTappedAround()
        
        collectionViewPokemon.delegate = self
        collectionViewPokemon.dataSource = self
        
        controller.arrayPokemons.append(PokemonTemp(name: "Bulbasaur", id: 001, type: "Charmander is a small, bipedal, dinosaur-like Pokémon. Most of its body is colored orange, while its underbelly is a light yellow color. Charmander, along with all of its evolved forms, has a flame that is constantly burning on the end of its tail.", description: "Grass", image: "Bulbasaur", hp: 100, atk: 80, def: 60, stak: 40, sdef: 20, spd: 50, favorite: true))
        controller.arrayPokemons.append(PokemonTemp(name: "Charizard", id: 002, type: "Charmander is a small, bipedal, dinosaur-like Pokémon. Most of its body is colored orange, while its underbelly is a light yellow color. Charmander, along with all of its evolved forms, has a flame that is constantly burning on the end of its tail.", description: "Fire", image: "Charizard", hp: 100, atk: 80, def: 60, stak: 40, sdef: 20, spd: 50, favorite: false))
        controller.arrayPokemons.append(PokemonTemp(name: "Charmander", id: 003, type: "Charmander is a small, bipedal, dinosaur-like Pokémon. Most of its body is colored orange, while its underbelly is a light yellow color. Charmander, along with all of its evolved forms, has a flame that is constantly burning on the end of its tail.", description: "Fire", image: "Charmander", hp: 100, atk: 80, def: 60, stak: 40, sdef: 20, spd: 50, favorite: false))
        controller.arrayPokemons.append(PokemonTemp(name: "Squirtle", id: 004, type: "Charmander is a small, bipedal, dinosaur-like Pokémon. Most of its body is colored orange, while its underbelly is a light yellow color. Charmander, along with all of its evolved forms, has a flame that is constantly burning on the end of its tail.", description: "Water", image: "Squirtle", hp: 100, atk: 80, def: 60, stak: 40, sdef: 20, spd: 50, favorite: true))
        
        loadFavorites()
        
    }
    
    func loadFavorites() {
        for item in controller.arrayPokemons {
            if item.favorite {
                pokemonFiltred.append(item)
            }
        }
        collectionViewPokemon.reloadData()
    }


}

extension PokemonFavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailView = PokemonDetailViewController.getPokemonDetails() {
            detailView.image = controller.arrayPokemons[indexPath.row].image
            detailView.name = controller.arrayPokemons[indexPath.row].name
            detailView.pokemonDescription = controller.arrayPokemons[indexPath.row].type
            detailView.hp = String(controller.arrayPokemons[indexPath.row].hp)
            detailView.atk = String(controller.arrayPokemons[indexPath.row].atk)
            detailView.def = String(controller.arrayPokemons[indexPath.row].def)
            detailView.stak = String(controller.arrayPokemons[indexPath.row].stak)
            detailView.sdef = String(controller.arrayPokemons[indexPath.row].sdef)
            detailView.spd = String(controller.arrayPokemons[indexPath.row].spd)
            present(detailView, animated: true, completion: nil)
        }
    }
}

extension PokemonFavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonFiltred.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesViewCell", for: indexPath) as! FavoritesViewCell
        cell.setup(pokemon: pokemonFiltred[indexPath.row])
        return cell
    }
}

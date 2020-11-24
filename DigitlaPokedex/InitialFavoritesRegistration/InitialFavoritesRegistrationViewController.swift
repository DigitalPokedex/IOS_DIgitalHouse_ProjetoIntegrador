//
//  InitialFavoritesRegistrationViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import UIKit

class InitialFavoritesRegistrationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var favoritesList = [Pokemon]()
    var allPokemonList = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", name: "Bulbasaur", id: 1, types: ["Grass", "Poison"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png", name: "Charizard", id: 6, types: ["Fire", "Flying"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/249.png", name: "Lugia", id: 249, types: ["Psychic", "Flying"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/150.png", name: "Mewtwo", id: 150, types: ["Psychic"]))
        
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png", name: "Ivysaur", id: 2, types: ["Grass", "Poison"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png", name: "Venusaur", id: 3, types: ["Grass", "Poison"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png", name: "Charmander", id: 4, types: ["Fire"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png", name: "Charmeleon", id: 5, types: ["Fire"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", name: "Squirtle", id: 7, types: ["Water"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png", name: "Wartotle", id: 8, types: ["Water"]))
        collectionView.reloadData()
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension InitialFavoritesRegistrationViewController: UICollectionViewDelegate {
    
}

extension InitialFavoritesRegistrationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.setup(pokemon: favoritesList[indexPath.row])
        return cell
    }
    
    
}

extension InitialFavoritesRegistrationViewController: UITableViewDelegate {
    
}

extension InitialFavoritesRegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        cell.setup(pokemon: allPokemonList[indexPath.row])
        return cell
    }
    
    
    
    
}

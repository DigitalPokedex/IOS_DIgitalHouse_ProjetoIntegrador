//
//  FavoritesViewCell.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 20/11/20.
//

import UIKit

class FavoritesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    
    private var pokemon: CompletePokemonRealm! = nil
    
//    func setup(pokemon: CompletePokemonRealm) {
//        imageViewPokemon.image = UIImage(named: pokemon.image)
//        labelName.text = pokemon.name.capitalizingFirstLetter()
//        labelId.text = "#00\(String(pokemon.id))"
//        labelDescription.text = pokemon.description
//    }
    
    func setId(id: Int) -> String {
        if id < 10 {
            return "#00\(id)"
        }
        if id < 100 {
            return "#0\(id)"
        }
        return "#\(id)"
    }
    
    func setup(pokemon: CompletePokemonRealm) {
        let url = URL(string: pokemon.sprites!)
        self.pokemon = pokemon
        imageViewPokemon.kf.setImage(with: url)
        labelName.text = pokemon.name!.capitalizingFirstLetter()
        labelId.text = setId(id: pokemon.id.value!)
    }
}

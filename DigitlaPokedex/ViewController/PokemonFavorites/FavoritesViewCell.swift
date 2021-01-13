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
    
    func setup(pokemon: PokemonTemp) {
        imageViewPokemon.image = UIImage(named: pokemon.image)
        labelName.text = pokemon.name
        labelId.text = "#00\(String(pokemon.id))"
        labelDescription.text = pokemon.description
    }
}

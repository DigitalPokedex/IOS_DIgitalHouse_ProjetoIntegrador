//
//  FavoriteCollectionViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import UIKit
import Kingfisher

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var minusButton: UIButton!
    private var pokemon: PokemonTemp2! = nil
    var onRemove: ((_ pokemon: PokemonTemp2) -> Void)?
    @IBAction func minusButtonAction(_ sender: Any) {
        onRemove?(pokemon)
    }
    
    func setup(pokemon: PokemonTemp2) {
        let url = URL(string: pokemon.image)
        self.pokemon = pokemon
        imageContainer.layer.cornerRadius = 45
        imageContainer.layer.borderWidth = 2
        imageContainer.frame.size.height = 80
        imageContainer.frame.size.width = 80
        minusButton.frame = CGRect(x: 70, y: 0, width: 30, height: 30)
        imageContainer.layer.borderColor = Colors.primary.cgColor
        pokemonImage.kf.setImage(with: url)

    }
    
    func remove(onRemove: @escaping (_ pokemon: PokemonTemp2) -> Void) {
        self.onRemove = onRemove
    }
}

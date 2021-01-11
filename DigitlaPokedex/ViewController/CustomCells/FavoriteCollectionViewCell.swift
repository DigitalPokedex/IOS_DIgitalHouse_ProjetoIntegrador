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
    private var pokemon: Pokemon! = nil
    var onRemove: ((_ pokemon: Pokemon) -> Void)?
    @IBAction func minusButtonAction(_ sender: Any) {
        onRemove?(pokemon)
    }
    
    func setup(pokemon: Pokemon) {
        let url = URL(string: pokemon.sprites.other.officialartwork.frontDefault)
        self.pokemon = pokemon
        
        
        imageContainer.layer.cornerRadius = 45
        imageContainer.layer.borderWidth = 2
        imageContainer.frame.size.height = 80
        imageContainer.frame.size.width = 80
        minusButton.frame = CGRect(x: 70, y: 0, width: 30, height: 30)
        imageContainer.layer.borderColor = Colors.primary.cgColor
        pokemonImage.kf.setImage(with: url)

    }
    
    func remove(onRemove: @escaping (_ pokemon: Pokemon) -> Void) {
        self.onRemove = onRemove
    }
}

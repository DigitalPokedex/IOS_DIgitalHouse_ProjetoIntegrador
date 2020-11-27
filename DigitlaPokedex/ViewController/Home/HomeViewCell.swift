//
//  HomeViewCell.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 20/11/20.
//

import UIKit

@IBDesignable extension UICollectionViewCell {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    
    func setup(pokemon: PokemonTemp) {
        imageViewPokemon.image = UIImage(named: pokemon.image)
        labelName.text = pokemon.name
        labelId.text = "#00\(String(pokemon.id))"
        labelType.text = pokemon.description
    }
    
}

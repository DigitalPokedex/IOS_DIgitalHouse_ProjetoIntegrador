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
    
    private var pokemon: Pokemon! = nil
    
    func setId(id: Int) -> String {
        if id < 10 {
            return "#00\(id)"
        }
        if id < 100 {
            return "#0\(id)"
        }
        return "#\(id)"
    }
    
    func setup(pokemon: Pokemon) {
        let url = URL(string: pokemon.sprites.other.officialartwork.frontDefault)
        self.pokemon = pokemon
        imageViewPokemon.kf.setImage(with: url)
        labelName.text = pokemon.name.capitalizingFirstLetter()
        labelId.text = setId(id: pokemon.id)
        labelType.text = pokemon.description
    }
    
}

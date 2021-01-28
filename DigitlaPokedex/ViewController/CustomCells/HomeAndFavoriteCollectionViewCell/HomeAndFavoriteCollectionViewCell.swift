//
//  HomeAndFavoriteCollectionViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 26/01/21.
//

import UIKit

class HomeAndFavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var firstTypeContainer: UIView!
    @IBOutlet weak var firstTypeLabel: UILabel!
    
    @IBOutlet weak var secondTypeContainer: UIView!
    @IBOutlet weak var secondTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setId(id: Int) -> String {
        if id < 10 {
            return "#00\(id)"
        }
        if id < 100 {
            return "#0\(id)"
        }
        return "#\(id)"
    }
    
    func setupTypes(_ types: [Type]) {
        firstTypeLabel.text = types[0].type.name.capitalizingFirstLetter()
        firstTypeContainer.layer.cornerRadius = 7
        firstTypeContainer.backgroundColor = UIColor(named: "GrassType")
        if(types.count > 1) {
            secondTypeLabel.text = types[1].type.name.capitalizingFirstLetter()
            secondTypeContainer.layer.cornerRadius = 7
            secondTypeContainer.backgroundColor = UIColor(named: "GrassType")
        } else {
            secondTypeContainer.backgroundColor = UIColor(named: "Transparent")
        }
    }
    
    func setupFromWeb(pokemon: Pokemon) {
        let url = URL(string: pokemon.sprites.other.officialartwork.frontDefault)
        
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemon.name.capitalizingFirstLetter()
        pokemonNumber.text = setId(id: pokemon.id)
        
        container.backgroundColor = UIColor(named: "GrassBackground")
        container.layer.cornerRadius = 15
        
        setupTypes(pokemon.types)
    }

    func setupFromDB(pokemon: CompletePokemonRealm) {
        let url = URL(string: pokemon.sprites!)
        
        container.backgroundColor = UIColor(named: "GrassBackground")
        container.layer.cornerRadius = 15
        
        
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemon.name!.capitalizingFirstLetter()
        pokemonNumber.text = setId(id: pokemon.id.value!)
        print(pokemon)
        
        setupTypes(pokemon.types!)
    }
}

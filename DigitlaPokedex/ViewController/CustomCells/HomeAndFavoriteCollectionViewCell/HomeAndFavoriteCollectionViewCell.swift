//
//  HomeAndFavoriteCollectionViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 26/01/21.
//

import UIKit
import Realm
import RealmSwift

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
    
    func getBackgroundColor(primaryType: String) -> UIColor? {
        if let backgroundColor = UIColor(named: "\(primaryType)Background") {
            return backgroundColor
        }
        return UIColor(named: "NormalBackground")
    }
    
    func getTypeColor(primaryType: String) -> UIColor? {
        if let backgroundColor = UIColor(named: "\(primaryType)Type") {
            return backgroundColor
        }
        return UIColor(named: "NormalType")
    }
    
    func setupTypesFromWeb(_ types: [Type]) {
        if(types.count > 0) {
            let primaryType = types[0].type.name.capitalizingFirstLetter()
            firstTypeLabel.text = primaryType
            firstTypeContainer.layer.cornerRadius = 7
            firstTypeContainer.backgroundColor = getTypeColor(primaryType: primaryType)
            secondTypeContainer.backgroundColor = getTypeColor(primaryType: primaryType)
            if(types.count > 1) {
                if let secondType = types[1].type.name?.capitalizingFirstLetter() {
                    secondTypeLabel.text = secondType
                    secondTypeContainer.layer.cornerRadius = 7
                }
            } else {
                secondTypeLabel.text = ""
                secondTypeContainer.backgroundColor = UIColor(named: "Transparent")
            }
        } else {
            self.firstTypeLabel.text = ""
            self.firstTypeContainer.backgroundColor = UIColor(named: "Transparent")
            self.secondTypeLabel.text = ""
            self.secondTypeContainer.backgroundColor = UIColor(named: "Transparent")
        }
    }
    
    func setupTypesFromDB(_ types: List<TypeRealm>) {
        if(types.count > 0) {
            if let primaryType = types[0].type.name?.capitalizingFirstLetter() {
                firstTypeLabel.text = primaryType
                firstTypeContainer.layer.cornerRadius = 7
                firstTypeContainer.backgroundColor = getTypeColor(primaryType: primaryType)
                secondTypeContainer.backgroundColor = getTypeColor(primaryType: primaryType)
            }
            if(types.count > 1) {
                if let secondType = types[1].type.name?.capitalizingFirstLetter() {
                    secondTypeLabel.text = secondType
                    secondTypeContainer.layer.cornerRadius = 7
                }
            } else {
                secondTypeLabel.text = ""
                secondTypeContainer.backgroundColor = UIColor(named: "Transparent")
            }
        } else {
            self.firstTypeLabel.text = ""
            self.firstTypeContainer.backgroundColor = UIColor(named: "Transparent")
            self.secondTypeLabel.text = ""
            self.secondTypeContainer.backgroundColor = UIColor(named: "Transparent")
        }
    }
    
    func setupPokemonName() {
        let screenWidth = ScreenSettings.screenWidth
        let cellWidth = ((screenWidth - 35) / 2)
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.widthAnchor.constraint(equalToConstant: cellWidth - 80).isActive = true
    }
    
    func setupFromWeb(_ pokemon: Pokemon) {
        let primaryType = pokemon.types[0].type.name.capitalizingFirstLetter()
        let url = URL(string: pokemon.sprites.other.officialartwork.frontDefault)
        
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemon.name.capitalizingFirstLetter()
        pokemonNumber.text = setId(id: pokemon.id)
        
        container.backgroundColor = getBackgroundColor(primaryType: primaryType)
        
        container.layer.cornerRadius = 15
        
        setupTypesFromWeb(pokemon.types)
    }
    
    func setupFromDB(_ pokemon: CompletePokemonRealm) {
        if let sprites = pokemon.sprites {
            let url = URL(string: sprites)
            pokemonImage.kf.setImage(with: url)
        }
        if let primaryType = pokemon.types[0].type.name?.capitalizingFirstLetter() {
            container.backgroundColor = getBackgroundColor(primaryType: primaryType)
        }
        
        container.layer.cornerRadius = 15
        pokemonName.text = pokemon.name!.capitalizingFirstLetter()
        pokemonNumber.text = setId(id: pokemon.id.value!)
        
        setupTypesFromDB(pokemon.types)
    }
    
    func setup(pokemon: AnyObject?) {
        print(pokemon)
        
        setupPokemonName()
        if let setupData = pokemon as? CompletePokemonRealm  {
            setupFromDB(setupData)
        } else if let setupData = pokemon as? Pokemon {
            setupFromWeb(setupData)
        }
    }
}

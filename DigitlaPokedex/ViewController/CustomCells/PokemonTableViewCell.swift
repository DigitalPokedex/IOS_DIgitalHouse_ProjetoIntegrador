//
//  PokemonTableViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    private var pokemon: PokemonTemp2! = nil
    var onAdd: ((_ pokemon: PokemonTemp2) -> Void)?
    @IBAction func plusButtonAction(_ sender: Any) {
        onAdd?(pokemon!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func setup(pokemon: PokemonTemp2) {
        let url = URL(string: pokemon.image)
        self.pokemon = pokemon
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemon.name
        pokemonNumber.text = setId(id: pokemon.id)
    }
    func add(onAdd: @escaping (_ pokemon: PokemonTemp2) -> Void) {
        self.onAdd = onAdd
    }
}

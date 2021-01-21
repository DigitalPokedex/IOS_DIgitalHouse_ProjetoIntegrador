//
//  SearchScreenTableViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import UIKit

class SearchScreenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pokemonName: UILabel!
    private var pokemon: PokemonRealm! = nil
    var onAdd: ((_ pokemon: PokemonRealm) -> Void)?
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
    
    func setup(pokemon: PokemonRealm) {
        pokemonName.text = pokemon.name!
    }
    
    func add(onAdd: @escaping (_ pokemon: PokemonRealm) -> Void) {
        self.onAdd = onAdd
    }
    
}

//
//  SearchScreenTableViewCell.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import UIKit

class SearchScreenTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pokemonName: UILabel!
    private var pokemon: SimplePokemonRealm! = nil
    var onAdd: ((_ pokemon: SimplePokemonRealm) -> Void)?
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
    
    func setup(pokemon: SimplePokemonRealm) {
        pokemonName.text = pokemon.name!
    }
    
    func add(onAdd: @escaping (_ pokemon: SimplePokemonRealm) -> Void) {
        self.onAdd = onAdd
    }
    
}

//
//  PokemonFavoritesViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit

class PokemonFavoritesViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewLogo.image = UIImage(named: "Logo")
    }
    

    

}

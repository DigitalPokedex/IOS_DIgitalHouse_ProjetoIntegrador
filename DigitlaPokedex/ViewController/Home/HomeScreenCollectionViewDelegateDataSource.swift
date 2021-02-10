//
//  CollectionViewDelegateDataSource.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 03/02/21.
//

import Foundation
import UIKit

class HomeScreenCollectionViewDelegateDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource  {
    let viewModel: HomeScreenViewModel!
    let screen: HomeViewController!
    
    init(viewModel: HomeScreenViewModel, screen: HomeViewController) {
        self.viewModel = viewModel
        self.screen = screen
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfCells(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.getCustomCollectionCell(collectionView: collectionView, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = ScreenSettings.screenWidth
        let cellWidth = ((screenWidth - 35) / 2)
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailView = PokemonDetailViewController.getPokemonDetails() {
            let pokemon = viewModel.filterArray[indexPath.row]
            detailView.image = pokemon.sprites.other.officialartwork.frontDefault
            detailView.name = pokemon.name.capitalizingFirstLetter()
            detailView.hp = String(pokemon.stats[0].baseStat)
            detailView.atk = String(pokemon.stats[1].baseStat)
            detailView.def = String(pokemon.stats[2].baseStat)
            detailView.stak = String(pokemon.stats[3].baseStat)
            detailView.sdef = String(pokemon.stats[4].baseStat)
            detailView.spd = String(pokemon.stats[5].baseStat)
            screen.present(detailView, animated: true, completion: nil)
        }
        
    }
}

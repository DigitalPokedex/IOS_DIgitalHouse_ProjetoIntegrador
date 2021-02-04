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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailView = PokemonDetailViewController.getPokemonDetails() {
            screen.present(detailView, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = ScreenSettings.screenWidth
        let cellWidth = ((screenWidth - 35) / 2)
        return CGSize(width: cellWidth, height: 80)
    }
}

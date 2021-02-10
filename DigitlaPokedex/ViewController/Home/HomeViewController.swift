//
//  ViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var collectionViewPokemon: UICollectionView!
    var searchScreen: UIView!
    var viewModel = HomeScreenViewModel()
//    var controller = PokemonConsetuptroller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewLogo.image = UIImage(named: "Logo")
        self.hideKeyboardWhenTappedAround()
        collectionViewPokemon.delegate = self
        collectionViewPokemon.dataSource = self
        
        self.viewModel.configureViewModel(navigationController: self.navigationController, collectionView: self.collectionViewPokemon)
        
        let nib = UINib(nibName: "HomeAndFavoriteCollectionViewCell", bundle: nil)
        self.collectionViewPokemon.register(nib, forCellWithReuseIdentifier: "HomeAndFavoriteCollectionViewCell")
        
        self.checkConnection()
    }
    
    func checkConnection() {
        if Reachability.isConnectedToNetwork() {
            loadInitialData()
        } else{
            let screenHeight = ScreenSettings.screenHeight
            let screenWidth = ScreenSettings.screenWidth
            let horizontalPosition = (screenWidth - 350) / 2
            let verticalPosition = (screenHeight / 2) - 205
//            let emptyState = EmptyState(frame: CGRect(x: CGFloat(horizontalPosition), y: CGFloat(verticalPosition), width: 350.0, height: 410.0))
//            self.view.addSubview(emptyState)
        }
    }
    
    
    func loadInitialData() {
        viewModel.loadSimplePokemonList(onComplete: { (success) in
            if(success) {
                self.viewModel.reloadData()
            }
        })
    }
    
    func configureSearchScreen() {
        searchScreen = SearchScreen(frame: CGRect(x: 00.0, y: 0.0, width: ScreenSettings.screenWidth, height: ScreenSettings.screenHeight), parentViewModel: self.viewModel, isInitialFavorites: false)
        self.view.addSubview(searchScreen)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.configureSearchScreen()
    }


}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailView = PokemonDetailViewController.getPokemonDetails() {
            let pokemon = viewModel.filterArray[indexPath.row]
            detailView.image = pokemon.sprites.other.officialartwork.frontDefault
            detailView.name = pokemon.name
            detailView.hp = String(pokemon.stats[0].baseStat)
            detailView.atk = String(pokemon.stats[1].baseStat)
            detailView.def = String(pokemon.stats[2].baseStat)
            detailView.stak = String(pokemon.stats[3].baseStat)
            detailView.sdef = String(pokemon.stats[4].baseStat)
            detailView.spd = String(pokemon.stats[5].baseStat)
            present(detailView, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfCells(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.getCustomCollectionCell(collectionView: collectionView, indexPath: indexPath)
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = ScreenSettings.screenWidth
        let cellWidth = ((screenWidth - 35) / 2)
        return CGSize(width: cellWidth, height: 80)
    }
}

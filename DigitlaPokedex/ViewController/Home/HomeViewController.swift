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
    //var controller = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewLogo.image = UIImage(named: "Logo")
        self.hideKeyboardWhenTappedAround()
        loadInitialData()
        collectionViewPokemon.delegate = self
        collectionViewPokemon.dataSource = self
        
        self.viewModel.configureViewModel(navigationController: self.navigationController, collectionView: self.collectionViewPokemon)
        
        let nib = UINib(nibName: "HomeAndFavoriteCollectionViewCell", bundle: nil)
        self.collectionViewPokemon.register(nib, forCellWithReuseIdentifier: "HomeAndFavoriteCollectionViewCell")
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
            /*detailView.image = controller.arrayPokemons[indexPath.row].image
            detailView.name = controller.arrayPokemons[indexPath.row].name
            detailView.pokemonDescription = controller.arrayPokemons[indexPath.row].type
            detailView.hp = String(controller.arrayPokemons[indexPath.row].hp)
            detailView.atk = String(controller.arrayPokemons[indexPath.row].atk)
            detailView.def = String(controller.arrayPokemons[indexPath.row].def)
            detailView.stak = String(controller.arrayPokemons[indexPath.row].stak)
            detailView.sdef = String(controller.arrayPokemons[indexPath.row].sdef)
            detailView.spd = String(controller.arrayPokemons[indexPath.row].spd)*/
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

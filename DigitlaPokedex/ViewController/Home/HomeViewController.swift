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
    var collectionViewDelegateDataSource: HomeScreenCollectionViewDelegateDataSource?
    var searchScreen: UIView!
    var viewModel = HomeScreenViewModel()
    //    var controller = PokemonConsetuptroller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.configureViewModel(navigationController: self.navigationController, collectionView: self.collectionViewPokemon)
        self.setupUI()
        self.checkConnection()
    }
    
    func setupUI() {
        configureCollectionView()
        imageViewLogo.image = UIImage(named: "Logo")
        self.hideKeyboardWhenTappedAround()
        let nib = UINib(nibName: "HomeAndFavoriteCollectionViewCell", bundle: nil)
        self.collectionViewPokemon.register(nib, forCellWithReuseIdentifier: "HomeAndFavoriteCollectionViewCell")
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
    
    func configureCollectionView() {
        self.collectionViewDelegateDataSource = HomeScreenCollectionViewDelegateDataSource(viewModel: self.viewModel, screen: self)
        self.collectionViewPokemon.delegate = collectionViewDelegateDataSource
        self.collectionViewPokemon.dataSource = collectionViewDelegateDataSource
        
        DispatchQueue.main.async {
            self.collectionViewPokemon.reloadData()
            
        }
    }
    @IBAction func searchButtonAction(_ sender: Any) {
        self.configureSearchScreen()
    }
    
}

//
//  InitialFavoritesRegistrationViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import UIKit

class InitialFavoritesRegistrationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchScreen: UIView!
    
    var viewModel = InitialFavoritesRegistrationViewModel()
    var tableViewDelegateDataSource: InitialFavoritesTableViewDelegateDataSource?
    var collectionViewDelegateDataSource: InitialFavoritesCollectionViewDelegateDataSource?
    var searchBarDelegate: InitialRegistrationSearchBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCollectionView()
        self.hideKeyboardWhenTappedAround()
        viewModel.configureViewModel(tableView: tableView, navigationController: self.navigationController)
        loadInitialData()
        
    }
    
    func configureSearchScreen() {
        searchScreen = SearchScreen(frame: CGRect(x: 00.0, y: 0.0, width: ScreenSettings.screenWidth, height: ScreenSettings.screenHeight))
        //searchScreen.configureSearchData()// = self.viewModel.allSimplePokemonData
        self.view.addSubview(searchScreen)
    }
    
    func reloadAllData() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func loadInitialData() {
        viewModel.loadSimplePokemonList(onComplete: { (success) in
            if(success) {
                self.reloadAllData()
            }
        })
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel.toHomeScreen()
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        viewModel.toPreviousScreen()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.configureSearchScreen()
    }
    func configureTableView() {
        self.tableViewDelegateDataSource = InitialFavoritesTableViewDelegateDataSource(viewModel: self.viewModel, collectionView: self.collectionView!)
        self.tableView.delegate = tableViewDelegateDataSource
        self.tableView.dataSource = tableViewDelegateDataSource
        //self.searchBar.delegate = searchBarDelegate
        
        DispatchQueue.main.async {
            self.reloadAllData()
        }
    }
    
    func configureCollectionView() {
        self.collectionViewDelegateDataSource = InitialFavoritesCollectionViewDelegateDataSource(viewModel: self.viewModel, tableView: self.tableView)
        self.collectionView.delegate = collectionViewDelegateDataSource
        self.collectionView.dataSource = collectionViewDelegateDataSource
        
        DispatchQueue.main.async {
            self.reloadAllData()
        }

    }
}





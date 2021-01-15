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
        configureSearchBar()
        self.hideKeyboardWhenTappedAround()
        viewModel.configureViewModel(tableView: tableView, navigationController: self.navigationController)
        loadInitialData()
        
    }
    
    func configureSearchScreen() {
        searchScreen = SearchScreen(frame: CGRect(x: 00.0, y: 0.0, width: ScreenSettings.screenWidth, height: ScreenSettings.screenHeight))
        self.view.addSubview(searchScreen)
    }
    
    func setupSearchBarColors() {
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor(named: "PrimaryLight")
        searchBar.searchTextField.textColor = UIColor(named: "Primary")
    }
    
    func reloadAllData() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func setupSearchBarIcons() {
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField, let clearButton = searchTextField.value(forKey:"_clearButton") as? UIButton {
            let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage, for: .normal)
            clearButton.tintColor = UIColor(named: "Primary")
        }
        if let textField = self.searchBar.value(forKey: "searchField") as? UITextField,
           let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor(named: "Primary")
        }
    }
    
    func setupSearchBarTextField(){
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "Primary")!])
        } else {
            let searchField = searchBar.value(forKey: "searchField") as! UITextField
            searchField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        }
    }
    
    func loadInitialData() {
        viewModel.loadSimplePokemonList(onComplete: { (success) in
            if(success) {
                self.reloadAllData()
                //self.configureSearchScreen()
            }
        })
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel.toHomeScreen()
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        viewModel.toPreviousScreen()
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
    
    func configureSearchBar() {
        setupSearchBarColors()
        setupSearchBarTextField()
        setupSearchBarIcons()
        
        self.searchBarDelegate = InitialRegistrationSearchBarDelegate(viewModel: self.viewModel, tableView: self.tableView!, collectionView: self.collectionView)
        self.searchBar.delegate = searchBarDelegate
        
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





//
//  SearchModal.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 13/01/21.
//

import Foundation
import UIKit

class SearchScreen: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gestureIndicator: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var initialModalCenter: CGFloat!
    private var finalModalCenter: CGFloat!
    
    var tableViewDelegateDataSource: SearchScreenTableViewDelegateDataSource?
    var searchBarDelegate: SearchBarDelegate?
    
    var viewModel = SearchScreenViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func closeScreen() {
        self.isHidden = true
    }
    
    func configureSearchData() {
        
    }
    
    func animateContainer(isInitial: Bool) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.containerView.center.y = isInitial ? CGFloat(0.0) : self.finalModalCenter
                       },
                       completion: {_ in
                        !isInitial ? self.closeScreen() : nil
                       })
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
    
    func setupSearchBarColors() {
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor(named: "PrimaryLight")
        searchBar.searchTextField.textColor = UIColor(named: "Primary")
    }
    
    func configureSearchBar() {
        setupSearchBarColors()
        setupSearchBarTextField()
        setupSearchBarIcons()
        
        self.searchBarDelegate = SearchBarDelegate(viewModel: self.viewModel, tableView: self.tableView!)
         self.searchBar.delegate = searchBarDelegate
         
         DispatchQueue.main.async {
            self.tableView.reloadData()
         }
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "SearchScreen") else { return }
        view.frame = self.bounds
        
        initialModalCenter = self.containerView.center.y
        finalModalCenter = (initialModalCenter * 2)
        
        self.viewModel.loadData()
        self.addSubview(view)
        self.configureTableView()
        self.animateContainer(isInitial: true)
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 35
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        
        gestureIndicator.backgroundColor = UIColor(named: "Primary")
        gestureIndicator.layer.cornerRadius = 3
        
        configureSearchBar()
    }
    
    func configureTableView() {
        
        self.tableViewDelegateDataSource = SearchScreenTableViewDelegateDataSource(viewModel: self.viewModel)
        self.tableView.delegate = tableViewDelegateDataSource
        self.tableView.dataSource = tableViewDelegateDataSource
        let nib = UINib(nibName: "SearchScreenTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SearchScreenTableViewCell")
        // self.searchBar.delegate = searchBarDelegate
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.animateContainer(isInitial: false)
    }
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: (type(of: self)))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

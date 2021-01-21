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
        print(self.center.y)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        isInitial ? self.containerView.center.y = 0 : nil
                       },
                       completion: {_ in
                        
                        print(self.containerView.center.y)
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
        
        /*self.searchBarDelegate = InitialRegistrationSearchBarDelegate(viewModel: self.viewModel, tableView: self.tableView!, collectionView: self.collectionView)
         self.searchBar.delegate = searchBarDelegate
         
         DispatchQueue.main.async {
         self.reloadAllData()
         }*/
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "SearchScreen") else { return }
        view.frame = self.bounds
        self.addSubview(view)
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
    @IBAction func closeButton(_ sender: Any) {
        print("Fechou")
        self.closeScreen()
    }
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: (type(of: self)))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

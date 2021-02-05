//
//  TabBarController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 09/11/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    static let shared = TabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
    }

    func loadViewControllers() {
        var arrayViews = [UIViewController]()

        /// DAQUI

        if let viewController1 = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as? HomeViewController {
            let image = UIImage(named: "PokemonIcon")
            let selectedImage = UIImage(named: "ActivePokemonIcon")
            viewController1.tabBarItem = UITabBarItem(title: "Pokémon", image: image, selectedImage: selectedImage)
            arrayViews.append(viewController1)
        }
        
        if let viewController2 = UIStoryboard(name: "PokemonFavorites", bundle: nil).instantiateInitialViewController() as? PokemonFavoritesViewController {
            let image = UIImage(named: "FavoritesIcon")
            let selectedImage = UIImage(named: "ActiveFavoritesIcon")
            viewController2.tabBarItem = UITabBarItem(title: "Favoritos", image: image, selectedImage: selectedImage)
            arrayViews.append(viewController2)
        }
        
        if let viewController3 = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? ProfileViewController {
            let image = UIImage(named: "ProfileIcon")
            let selectedImage = UIImage(named: "ProfileIcon")
            viewController3.tabBarItem = UITabBarItem(title: "Perfil", image: image, selectedImage: selectedImage)
            arrayViews.append(viewController3)
        }

        /// AQUI
                
        viewControllers = arrayViews
        
        self.selectedIndex = 0
    }
}


extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!

        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}

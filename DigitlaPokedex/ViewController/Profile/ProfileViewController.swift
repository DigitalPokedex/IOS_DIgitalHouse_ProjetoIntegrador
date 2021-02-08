//
//  ProfileViewController.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 03/02/21.
//

import UIKit

class ProfileViewController: UIViewController {

    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionButtonLogOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "LOGOUT", message: "Tem certeza que deseja sair?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Sair", style: .default, handler: { action in
            self.viewModel.logOutConnections()
            //viewModel.changeRootViewController()
            guard let loginVC =  self.navigationController?.viewControllers[1] else { return }
            self.navigationController?.popToViewController(loginVC, animated: true)
            
          //  self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
}

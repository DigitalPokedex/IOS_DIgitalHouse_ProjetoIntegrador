//
//  LoginScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var lugiaImage: UIImageView!
    
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lugiaImage)
        loginContainer.layer.cornerRadius = 35
        loginContainer.backgroundColor = Colors.grey
        loginContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginContainer.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 15
        passwordInput.layer.cornerRadius = 35
        configureTextInputs()
        self.hideKeyboardWhenTappedAround()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenHeight = ScreenSettings.screenHeight
        let screenWidth = ScreenSettings.screenWidth
        let imageSize = screenHeight * 0.2586 <= 210 ? screenHeight * 0.2586 : CGFloat(210)
        let loginContainerHeight = CGFloat(446)
        if imageSize < 210 {
            lugiaImage.frame = CGRect(x: (screenWidth - imageSize)  / 2, y: screenHeight - 20 - loginContainerHeight - imageSize, width: imageSize, height: imageSize)
        }
    }

    func configureTextInputs() {
        let emailLeftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        emailInput.leftView = emailLeftView
        emailInput.leftViewMode = .always
        emailInput.layer.cornerRadius = 15
        
        let passwordLeftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        passwordInput.leftView = passwordLeftView
        passwordInput.leftViewMode = .always
        passwordInput.layer.cornerRadius = 15
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
    @IBAction func signUpButtonAction(_ sender: Any) {
        let signUpViewController = UIStoryboard(name: "SignUpScreen", bundle: nil).instantiateInitialViewController() as! SignUpScreenViewController
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

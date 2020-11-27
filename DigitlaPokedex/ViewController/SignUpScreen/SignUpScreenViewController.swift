//
//  SignUpScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    @IBOutlet weak var inputsContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.addSubview(inputsContainer)
        
        configureTextInputs()
    }
    @IBAction func previousScreenAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureTextInputs() {
        let nameLeftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        nameTextField.leftView = nameLeftView
        nameTextField.leftViewMode = .always
        nameTextField.layer.cornerRadius = 15
        
        let passwordLeftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        passwordTextField.leftView = passwordLeftView
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = 15
        
        let emailLeftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        emailTextField.leftView = emailLeftView
        emailTextField.leftViewMode = .always
        emailTextField.layer.cornerRadius = 15
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //inputsContainer.frame.size.height = CGFloat(300)
        inputsContainer.layer.cornerRadius = 35
        inputsContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        inputsContainer.layer.masksToBounds = true
        let screenHeight = ScreenSettings.screenHeight
        let screenWidth = ScreenSettings.screenWidth
        var containerHeight = CGFloat(380)
        if screenHeight * 0.7278 >= containerHeight {
            if screenHeight * 0.7278 > 591 {
                containerHeight = CGFloat(591)
            } else {
                containerHeight = screenHeight * 0.7278
            }
        }
        
        inputsContainer.frame = CGRect(x: 0, y: screenHeight - CGFloat(containerHeight), width: screenWidth, height: containerHeight)
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        let viewController = UIStoryboard(name: "InitialFavoritesRegistration", bundle: nil).instantiateInitialViewController() as! InitialFavoritesRegistrationViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if (textField == textFieldName) {
//            if(itemList.exists(textFieldName.text!)) {
//                textFieldQuantity.text = String(itemList.getItem(name: textFieldName.text!)!.quantity)
//                saveButton.setTitle("Salvar edição", for: .normal)
//                deleteButton.isHidden = false
//                view.endEditing(true)
//            }
//            else {
//                textFieldQuantity.becomeFirstResponder()
//            }
//        }
//        else {
//            view.endEditing(true)
//        }
        return true
    }
}

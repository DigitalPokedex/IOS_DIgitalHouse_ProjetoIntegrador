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
    
    @IBOutlet weak var logoImage: UIImageView!
    
    let screenHeight = ScreenSettings.screenHeight
    let screenWidth = ScreenSettings.screenWidth
    var containerHeight = CGFloat(380)
    
    var viewModel = SignUpScreenViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewModel.setupNavigationController(navigationController: self.navigationController, screen: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func calculateContainerHeight() {
        if screenHeight * 0.7278 >= containerHeight {
            if screenHeight * 0.7278 > 591 {
                containerHeight = CGFloat(591)
            } else {
                containerHeight = screenHeight * 0.7278
            }
        }
    }
    
    func configureInputsContainer() {
        inputsContainer.layer.cornerRadius = 35
        inputsContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        inputsContainer.layer.masksToBounds = true
        
        inputsContainer.frame = CGRect(x: 0, y: self.screenHeight - CGFloat(self.containerHeight), width: self.screenWidth, height: self.containerHeight)
    }
    
    func configureLogo() {
        let x = logoImage.frame.origin.x
        let y = self.screenHeight - CGFloat(self.containerHeight) - 30.0
        logoImage.frame = CGRect(x: x, y: y, width: 193, height: 61)
        
        self.view.bringSubviewToFront(logoImage)
    }
    
    func configureTextField(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 15
    }
    
    func setupUI() {
        view.addSubview(inputsContainer)
        
        calculateContainerHeight()
        configureInputsContainer()
        configureLogo()
        
        configureTextField(textField: nameTextField)
        configureTextField(textField: passwordTextField)
        configureTextField(textField: emailTextField)
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        viewModel.toPreviousScreen()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel.saveButtonAction(email: emailTextField.text!, password: passwordTextField.text!)
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
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

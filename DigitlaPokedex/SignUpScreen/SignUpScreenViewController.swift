//
//  SignUpScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 15/11/20.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    @IBOutlet weak var inputsContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(inputsContainer)
    }
    @IBAction func previousScreenAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

}

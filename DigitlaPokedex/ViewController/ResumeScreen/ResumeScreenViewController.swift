//
//  ResumeScreenViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 04/02/21.
//

import UIKit

class ResumeScreenViewController: UIViewController {

    static let shared = ResumeScreenViewController()
    
    let viewModel = ResumeScreenViewModel()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorsContainer: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var toLoginScreenButton: UIButton!
    @IBOutlet weak var imagesContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    static func getFirstScreen() -> ResumeScreenViewController? {
        if(!ResumeScreenViewModel.existSaveData()) {
            let viewDefault = UIStoryboard(name: "ResumeScreen", bundle: nil).instantiateInitialViewController() as! ResumeScreenViewController
            return viewDefault
        }
        
        return nil
        
    }
    
    func setupCircles() {
        let indicatorHorizontalPosition = ((indicatorsContainer.frame.width - 10) / 2) - 20
        for index in 0...(viewModel.imageNames.count - 1) {
            let indicator = UIView()
            indicator.layer.cornerRadius = 5
            let isActive = index == viewModel.activeImage
            if(isActive) {
                indicator.backgroundColor = UIColor(named: "Primary")
            } else {
                indicator.backgroundColor = Colors.grey
            }
            indicator.frame = CGRect(x: indicatorHorizontalPosition + CGFloat(20 * index), y: 20, width: 10, height: 10)
            indicatorsContainer.addSubview(indicator)
        }
    }
    
    func setupImages() {
        let imageHeight = imagesContainer.frame.height * 0.7741
        let imageWidth = imageHeight * 0.454343
        let imageVerticalPosition = (imagesContainer.frame.height - imageHeight) / 2
        let imageHorizontalPosition = (imagesContainer.frame.width - imageWidth) / 2
        
        for index in 0...(viewModel.imageNames.count - 1) {
            let image = UIImage(named: viewModel.imageNames[index])
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: imageHorizontalPosition + (imageHorizontalPosition * CGFloat(5 * index)), y: imageVerticalPosition, width: imageWidth, height: imageHeight)
            imagesContainer.addSubview(imageView)
        }
        
    }
    
    func setupButtonUI(button: UIButton, isActive: Bool) {
        button.layer.cornerRadius = 25
        if(!isActive) { button.isHidden = true }
    }
    
    func setupButtons() {
        setupButtonUI(button: leftButton, isActive: false)
        setupButtonUI(button: toLoginScreenButton, isActive: false)
        setupButtonUI(button: rightButton, isActive: true)
        
        viewModel.setupButtons(leftButton: leftButton, rightButton: rightButton, toLoginScreenButton: toLoginScreenButton)
    }
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true

        setupButtons()
        
        setupImages()
        setupCircles()
        
        viewModel.titleLabel = titleLabel
    }

    @IBAction func leftButtonAction(_ sender: Any) {
        self.viewModel.animateTo(orientation: "left", imagesContainer: imagesContainer, indicatorsContainer: indicatorsContainer)
    }
    @IBAction func rightButtonAction(_ sender: Any) {
        self.viewModel.animateTo(orientation: "right", imagesContainer: imagesContainer, indicatorsContainer: indicatorsContainer)
    }
    @IBAction func toLoginScreenButtonAction(_ sender: Any) {
        viewModel.toLoginScreen(navigationController: navigationController)
    }
}

//
//  ResumeScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 04/02/21.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class ResumeScreenViewModel {
    let imageNames = ["homeResume", "detailsResume", "favoritesResume"]
    let titles = ["Search for the desired Pokémon!", "See characteristics of each Pokémon!", "Add Pokémon to favorites list!"]
    var activeImage = 0
    
    
    var titleLabel: UILabel!
    var leftButton: UIButton!
    var rightButton: UIButton!
    var toLoginScreenButton: UIButton!
    
    static func existSaveData() -> Bool {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        let existData = dataRealm.count == 0
        
        return !existData
    }
    
    func setupButtons(leftButton: UIButton, rightButton: UIButton, toLoginScreenButton: UIButton) {
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.toLoginScreenButton = toLoginScreenButton
    }
    
    func setIndicatorBackground(indicatorsContainer: UIView) {
        for index in 0...(imageNames.count - 1) {
            let isActive = index == activeImage
            if(isActive) {
                indicatorsContainer.subviews[index].backgroundColor = UIColor(named: "Primary")
            } else {
                indicatorsContainer.subviews[index].backgroundColor = Colors.grey
            }
        }
    }
    func setTitleText() {
        for index in 0...(titles.count - 1) {
            let isActive = index == activeImage
            if(isActive) {
                titleLabel.text = titles[index]
            }
        }
    }
    
    func animateTo(orientation: String, imagesContainer: UIView, indicatorsContainer: UIView) {
        let imageHeight = imagesContainer.frame.height * 0.7741
        let imageWidth = imageHeight * 0.454343
        let imageHorizontalPosition = (imagesContainer.frame.width - imageWidth) / 2
        let numberOfImages = imagesContainer.subviews.count  - 1
        
        UIView.animate(withDuration: 0.5,
                            delay: 0,
                            options: .curveEaseOut,
                            animations: {
                                for index in 0...(numberOfImages) {
                                    let currentCenter = imagesContainer.subviews[index].center.x
                                    if(orientation == "right" && self.activeImage != numberOfImages) {
                                        imagesContainer.subviews[index].center.x = currentCenter - (CGFloat(imageHorizontalPosition * 5))
                                    } else if(orientation == "left" && self.activeImage != 0) {
                                        imagesContainer.subviews[index].center.x = currentCenter + (CGFloat(imageHorizontalPosition * 5))
                                    }
                                }
                            },
                            completion: {_ in
                                if(orientation == "right" && self.activeImage != numberOfImages) {
                                    self.activeImage += 1
                                } else if(orientation == "left" && self.activeImage != 0) {
                                    self.activeImage -= 1
                                }
                                if(self.activeImage == 0) {
                                    self.leftButton.isHidden = true
                                    self.rightButton.isHidden = false
                                    self.toLoginScreenButton.isHidden = true
                                } else if(self.activeImage == numberOfImages) {
                                    self.rightButton.isHidden = true
                                    self.leftButton.isHidden = false
                                    self.toLoginScreenButton.isHidden = false
                                } else {
                                    self.leftButton.isHidden = false
                                    self.rightButton.isHidden = false
                                    self.toLoginScreenButton.isHidden = true
                                }
                                self.setIndicatorBackground(indicatorsContainer: indicatorsContainer)
                                self.setTitleText()
                            })
    }
    func toFirstScreen() {
        let nav = UIStoryboard(name: "FirstScreen", bundle: nil).instantiateInitialViewController() as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = nav
    }
}

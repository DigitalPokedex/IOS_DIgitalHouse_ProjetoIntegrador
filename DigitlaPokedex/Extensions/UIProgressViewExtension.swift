//
//  UIProgressViewExtension.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 07/12/20.
//

import Foundation
import UIKit

extension UIProgressView {
    
    func updateProgress(currentProgress: Float, maxProgress: Float) {
        var current = currentProgress + 1.0
        self.progress = current/100
        
        
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
            if current < maxProgress {
                current = current + 1.0
                self.progress = current/100
            } else {
                timer.invalidate()
            }
        }
        
        
    }
    
}

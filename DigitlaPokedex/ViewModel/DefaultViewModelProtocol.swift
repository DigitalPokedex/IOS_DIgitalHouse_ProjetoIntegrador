//
//  DefailtViewModelProtocol.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 22/01/21.
//

import Foundation

protocol DefaultViewModelProtocol {
    
    func reloadData()
    
    func returnListWithCompleteData() -> [Pokemon]
}

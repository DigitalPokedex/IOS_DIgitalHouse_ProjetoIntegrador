//
//  StringExtensions.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 21/01/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

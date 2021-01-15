//
//  SearchModal.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 13/01/21.
//

import Foundation
import UIKit

class SearchScreen: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "SearchScreen") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    @IBAction func closeButton(_ sender: Any) {
        print("Fechou")
        self.isHidden = true
    }
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: (type(of: self)))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

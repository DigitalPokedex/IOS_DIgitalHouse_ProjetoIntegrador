//
//  EmptyState.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 01/02/21.
//

import UIKit

class EmptyState: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("EmptyState", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}

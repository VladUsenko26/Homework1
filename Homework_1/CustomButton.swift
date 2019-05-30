//
//  CustomButton.swift
//  Homework_1
//
//  Created by Влад on 5/29/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 6 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.purple {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable var buttonTitleColor : UIColor = .white
    
    @IBInspectable var buttonSelectedTitleColor : UIColor = .white
    
    var buttonColor : UIColor = .orange
    
    var buttonSelectedColor : UIColor = .white
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        } set {
            super.isHighlighted = newValue
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        } set {
            self.layer.backgroundColor = newValue ? buttonSelectedColor.cgColor : buttonColor.cgColor
            super.isSelected = newValue
        }
    }
}

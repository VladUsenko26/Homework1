//
//  CustomView.swift
//  Homework_1
//
//  Created by Влад on 6/3/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import UIKit

class CustomView: UIView {

    
    class func create (with frame : CGRect) -> CustomView? {
        let nibs = Bundle.main.loadNibNamed(String.init(describing: self), owner: self, options: nil)
        guard let customView = nibs?.first as? CustomView else {
            return nil
        }
        customView.frame = frame
        customView.alpha = 0.0
        
        return customView
    }
    
    func show () {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: { self.alpha = 1.0 }, completion: nil)
    }
}

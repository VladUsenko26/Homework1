//
//  UIVIewExtension.swift
//  Homework_1
//
//  Created by Влад on 6/8/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

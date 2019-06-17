//
//  BenchamrkCollectionViewCell.swift
//  Homework_1
//
//  Created by Влад on 6/17/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import UIKit

class BenchmarkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timerLabel_1: UILabel!
    @IBOutlet weak var timerLabel_2: UILabel!
    
    static var id: String {
        return String(describing: self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}

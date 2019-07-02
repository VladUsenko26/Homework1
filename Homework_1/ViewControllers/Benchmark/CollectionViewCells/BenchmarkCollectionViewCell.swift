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
    
    private var timer: Timer?
    private var isPaused: Bool = false
    
    static var id: String {
        return String(describing: self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !isPaused {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func runTimed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        let dateString = dateFormatter.string(from: Date())
        self.timerLabel_1.text = dateString
        self.timerLabel_2.text = dateString
    }
    
    func pauseTimer () {
        if isPaused{
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
            isPaused = false
        } else {
            guard let timer = self.timer else {
                return
            }
            timer.invalidate()
            isPaused = true
        }
    }
}

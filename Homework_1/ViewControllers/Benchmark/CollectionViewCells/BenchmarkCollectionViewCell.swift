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
    
    private var timer: Timer?
    private var backTimer: Timer?
    private var isPaused: Bool = false
    private var startTime: Int = 0
    private var pauseTime: Int = 0
    private var startSegment = Segment(color: .red, value: 50, title: "Red")
    private var endSegment = Segment(color: .blue, value: 50, title: "Blue")
    static var id: String {
        return String(describing: self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let segments:[Segment] = [startSegment, endSegment]
        self.pieChartView.setup(segmentArr: segments)
        
        if !isPaused {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
        } else {
            self.backTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                [weak self] timer in
                
                guard let `self` = self else {
                    return
                }
                
                self.pauseTime += 1
            }
        }
    }
    
    @objc private func runTimed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        let dateString = dateFormatter.string(from: Date())
        self.timerLabel_1.text = dateString
        startTime += 1
        self.updateChart()
    }
    
    func pauseTimer () {
        if isPaused{
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
            guard let backTimer = self.backTimer else {
                return
            }
            backTimer.invalidate()
            isPaused = false
        } else {
            guard let timer = self.timer else {
                return
            }
            timer.invalidate()
            self.backTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                [weak self] timer in
                guard let `self` = self else {
                    return
                }
                
                self.pauseTime += 1
                self.updateChart()
            }
            isPaused = true
        }
    }
    
    func updateChart () {
        startSegment.value = CGFloat(startTime)
        endSegment.value = CGFloat(pauseTime)
        self.pieChartView.setup(segmentArr: [startSegment, endSegment])
    }
}

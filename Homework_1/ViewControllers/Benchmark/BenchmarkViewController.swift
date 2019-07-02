//
//  BenchmarkViewController.swift
//  Homework_1
//
//  Created by Влад on 6/8/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import Foundation
import UIKit

class BenchmarkViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(BenchmarkCollectionViewCell.cellNib, forCellWithReuseIdentifier: BenchmarkCollectionViewCell.id)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       
        addBehaviors(behaviors: [TimerBehavior()])
    }
    
}

extension BenchmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BenchmarkCollectionViewCell.id, for: indexPath) as! BenchmarkCollectionViewCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? BenchmarkCollectionViewCell
        if let cell = cell {
            cell.pauseTimer()
        }
    }
    
}


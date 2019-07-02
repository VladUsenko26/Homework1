//
//  ThirdViewController.swift
//  Homework_1
//
//  Created by Влад on 6/10/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }
    
   
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFeedTableView", for: indexPath)
        
        let contentView = UIView(frame: cell.frame)
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 20))
        label.text = "go to next VC"
        contentView.addSubview(label)
        cell.addSubview(contentView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SessionSummaryViewController")
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
}



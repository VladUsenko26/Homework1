//
//  ThirdViewController.swift
//  Homework_1
//
//  Created by Влад on 6/10/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToRootVC(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

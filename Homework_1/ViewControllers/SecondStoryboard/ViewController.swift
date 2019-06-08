//
//  ViewController.swift
//  Homework_1
//
//  Created by Влад on 5/29/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let customView = CustomView.create(with: CGRect(x: self.view.frame.width/4, y: self.view.frame.height/4, width: self.view.frame.width/4, height: self.view.frame.height/4) ) {
            self.view.addSubview(customView)
            customView.show()
        }
    }


}


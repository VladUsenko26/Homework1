//
//  ProfileViewController.swift
//  Homework_1
//
//  Created by Влад on 6/8/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBehaviors(behaviors: [ChangeColorBehavior()])
    }
}

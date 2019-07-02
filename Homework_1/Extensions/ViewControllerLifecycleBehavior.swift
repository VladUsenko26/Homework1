//
//  ViewControllerLifecycleBehavior.swift
//  Homework_1
//
//  Created by Влад on 6/8/19.
//  Copyright © 2019 Влад. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerLifecycleBehavior {
    func afterLoading(_ viewController: UIViewController)
    
    func beforeAppearing(_ viewController: UIViewController)
    
    func afterAppearing(_ viewController: UIViewController)
    
    func beforeDisappearing(_ viewController: UIViewController)
    
    func afterDisappearing(_ viewController: UIViewController)
    
    func beforeLayingOutSubviews(_ viewController: UIViewController)
    
    func afterLayingOutSubviews(_ viewController: UIViewController)
}

extension ViewControllerLifecycleBehavior {
    func afterLoading(_ viewController: UIViewController) {}
    
    func beforeAppearing(_ viewController: UIViewController) {}
    
    func afterAppearing(_ viewController: UIViewController) {}
    
    func beforeDisappearing(_ viewController: UIViewController) {}
    
    func afterDisappearing(_ viewController: UIViewController) {}
    
    func beforeLayingOutSubviews(_ viewController: UIViewController) {}
    
    func afterLayingOutSubviews(_ viewController: UIViewController) {}
}
protocol TimerBehaviorDelegate {
    func newTime (date: Date)
    func timerInvalidated()
}

class TimerBehavior: ViewControllerLifecycleBehavior {
    private var timer: Timer?
    private var isPaused = false
    var delegate: TimerBehaviorDelegate?
    
    @objc private func runTimed () {
        print(Date())
        self.delegate?.newTime(date: Date())
    }
    
    func afterAppearing(_ viewController: UIViewController) {
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        
        guard let timer = self.timer else {
            return
        }
        timer.invalidate()
        self.delegate?.timerInvalidated()
    }
    
    func pauseTimer () {
        if isPaused{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimed), userInfo: nil, repeats: true)
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

class ChangeColorBehavior: ViewControllerLifecycleBehavior {
    private var defaultColor: UIColor?
    
    func afterAppearing(_ viewController: UIViewController) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        viewController.navigationController?.navigationBar.barStyle = .black
        self.defaultColor = viewController.view.backgroundColor
        viewController.view.backgroundColor = UIColor.black
        
    }
    func beforeDisappearing(_ viewController: UIViewController) {
        UIApplication.shared.statusBarStyle = .default
        viewController.navigationController?.navigationBar.barStyle = .default
        guard let color = self.defaultColor else {
            return
        }
        viewController.view.backgroundColor = color
    }
    
}


extension UIViewController {
    /*
     Add behaviors to be hooked into this view controller’s lifecycle.
     
     This method requires the view controller’s view to be loaded, so it’s best to call
     in `viewDidLoad` to avoid it being loaded prematurely.
     
     - parameter behaviors: Behaviors to be added.
     */
    func addBehaviors(behaviors: [ViewControllerLifecycleBehavior]) {
        let behaviorViewController = LifecycleBehaviorViewController(behaviors: behaviors)
        
        addChild(behaviorViewController)
        view.addSubview(behaviorViewController.view)
        behaviorViewController.didMove(toParent: self)
    }
    
    private final class LifecycleBehaviorViewController: UIViewController {
        private let behaviors: [ViewControllerLifecycleBehavior]
        
        // MARK: - Initialization
        
        init(behaviors: [ViewControllerLifecycleBehavior]) {
            self.behaviors = behaviors
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.isHidden = true
            
            applyBehaviors { behavior, viewController in
                behavior.afterLoading(viewController)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeAppearing(viewController)
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterAppearing(viewController)
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeDisappearing(viewController)
            }
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterDisappearing(viewController)
            }
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.beforeLayingOutSubviews(viewController)
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.afterLayingOutSubviews(viewController)
            }
        }
        
        // MARK: - Private
        
        private func applyBehaviors(body: (_ behavior: ViewControllerLifecycleBehavior, _ viewController: UIViewController) -> ()) {
            guard let parentViewController = parent else { return }
            
            for behavior in behaviors {
                body(behavior, parentViewController)
            }
        }
    }
}

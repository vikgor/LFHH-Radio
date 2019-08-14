//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 8/13/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let notification = NotificationCenter.default
    @IBAction func timerButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) { // Change `2.0` to the desired number of seconds.
            print("Delayed code executed: Radio paused")
            self.notification.post(name: Notification.Name("PauseMusic"), object: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

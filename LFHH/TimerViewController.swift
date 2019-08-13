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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            print("FIRE!!!")
            
//            ViewController().stupid()
            
            //post a notification when that button is pressed
            self.notification.post(name: Notification.Name("PauseMusic"), object: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

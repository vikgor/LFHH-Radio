//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 8/13/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    
    
    let notification = NotificationCenter.default
    var pickerData = [1, 2, 3, 5, 10, 30, 60]
    var pickedSeconds: Double = 2.0
    
    @IBOutlet weak var sleepTimerMinutes: UIPickerView!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleepTimerMinutes.delegate = self
        sleepTimerMinutes.dataSource = self
        // Input the data into the array
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedSeconds = Double(pickerData[row])
    }
    
    
    
    @IBAction func timerButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + pickedSeconds) { // Change `30.0` to the desired number of seconds.
            print("Delayed code executed: Radio paused")
            self.notification.post(name: Notification.Name("PauseMusic"), object: nil)
        }
    }
}

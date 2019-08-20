//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 8/13/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    @IBOutlet weak var sleepTimerMinutes: UIPickerView!
    var pickerData = ["1 minute", "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour",]
    var pickerMinutes: [Int] = [ 10, 20, 30, 40, 1800, 2400, 3600] //In seconds for testing, change this later
    var pickerSeconds = 10
    
    
    @IBOutlet weak var labelTimer: UILabel!
    var timer = Timer()
    var sleepTimerIsOn = false
    
    @IBOutlet weak var timerButton: UIButton!
    let notification = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleepTimerMinutes.delegate = self
        sleepTimerMinutes.dataSource = self
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
        pickerSeconds = pickerMinutes[row]
    }
    
    
    @objc func countdownTimer() {
        print(pickerSeconds)
        if pickerSeconds >= 0 {
            let minutes = String(format: "%02d", pickerSeconds / 60)
            let seconds = String(format: "%02d", pickerSeconds % 60)
            labelTimer.text = minutes + ":" + seconds
            pickerSeconds -= 1
        }
        if pickerSeconds < 0 {
            sleepTimerIsOn = false
            print("Countdown has ended. Radio paused.")
            timerButton.setTitle("Chill...", for: .normal)
            notification.post(name: Notification.Name("PauseMusic"), object: nil)
            timer.invalidate()
        }
    }
    
    @IBAction func timerButton(_ sender: Any) {
        if sleepTimerIsOn {
            timer.invalidate()
            sleepTimerIsOn = false
            sleepTimerMinutes.isUserInteractionEnabled = true
            timerButton.setTitle("Chill...", for: .normal)
        } else {
            sleepTimerIsOn = true
            sleepTimerMinutes.isUserInteractionEnabled = false
            timerButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
        }
    }
}

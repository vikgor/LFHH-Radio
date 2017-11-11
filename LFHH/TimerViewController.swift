//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 8/13/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    @IBOutlet weak var labelTimer: UILabel!
    var counter = 10
    var timer = Timer()
    var sleepTimerIsOn = false
    var isPlaying = true
    @IBOutlet weak var timerButton: UIButton!
    
    let notification = NotificationCenter.default
    var pickerData = ["1 minute", "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour",]
//    var pickerMinutes: [Double] = [ 1, 5, 10, 15, 30, 45, 60]
    var pickerMinutes: [Double] = [ 10, 20, 30, 40, 1800, 2400, 3600]
    var pickerSeconds: Double = 10.0
    
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
        pickerSeconds = pickerMinutes[row]
        counter = Int(pickerSeconds)
    }
    
    @objc func countdownTimer() {
        
        //FIX THIS
        
        print(counter)
        
        if counter >= 0 {
            let minutes = String(format: "%02d", counter / 60)
            let seconds = String(format: "%02d", counter % 60)
            labelTimer.text = minutes + ":" + seconds
            counter -= 1
        }
        if counter < 0 {
            isPlaying = false
            print("Countdown has ended")
            timer.invalidate()
            
            timerButton.setTitle("Chill...", for: .normal)
        }

    }
    
    @IBAction func timerButton(_ sender: Any) {

        let sleepMusiс = DispatchWorkItem {
                print("Delayed code executed: Radio paused")
                self.notification.post(name: Notification.Name("PauseMusic"), object: nil)
                self.sleepTimerMinutes.isUserInteractionEnabled = true
        }
        
        if isPlaying{
            timerButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
            isPlaying = false
            sleepTimerMinutes.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + pickerSeconds, execute: sleepMusiс)
            
            
        } else {
            
            sleepMusiс.cancel()
//            sleepMusiс.cancel()//doesnt work
            timerButton.setTitle("Chill...", for: .normal)
            timer.invalidate()
            counter = Int(pickerSeconds)
            isPlaying = true
            sleepTimerMinutes.isUserInteractionEnabled = true
        }
        
        
        
    }
}

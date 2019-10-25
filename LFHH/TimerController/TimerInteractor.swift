//
//  TimerInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/24/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation

class TimerInteractor {
    
    var presenter = TimerPresenter()
    
    var pickerData = ["1 minute", "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour",]
    var pickerMinutes: [Int] = [60, 300, 600, 900, 1800, 2400, 3600] //In seconds for testing, change this later
    var pickerSeconds = 60
    var timer = Timer()
    var sleepTimerIsOn = false
    let notification = NotificationCenter.default
    
    @objc func countdownTimer() {
        print(pickerSeconds)
        if pickerSeconds >= 0 {
            let minutes = String(format: "%02d", pickerSeconds / 60)
            let seconds = String(format: "%02d", pickerSeconds % 60)
            let timerLabelText = minutes + ":" + seconds
            pickerSeconds -= 1
            presenter.setTimerLabelText(string: timerLabelText)
        }
        if pickerSeconds < 0 {
            sleepTimerIsOn = false
            print("Countdown has ended. Radio paused.")
            notification.post(name: Notification.Name("PauseMusic"), object: nil)
            timer.invalidate()
            presenter.setTimerButtonTitle(string: "Chilling...")
        }
    }
    
    func timerButton() {
        if sleepTimerIsOn {
            timer.invalidate()
            sleepTimerIsOn = false
            presenter.setTimerButtonTitle(string: "Resume")
            presenter.pickerUserInteractionSwitcher()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
            sleepTimerIsOn = true
            presenter.setTimerButtonTitle(string: "Stop")
            presenter.pickerUserInteractionSwitcher()
        }
    }
}

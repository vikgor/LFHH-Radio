//
//  TimerInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol TimerBusinessLogic {
    func startTimer()
}

final class TimerInteractor {
    
    var presenter: TimerPresentationLogic?
    
    var timer = Timer()
    var sleepTimerIsOn = false
    let notification = NotificationCenter.default
    
}

// MARK: - TimerBusinessLogic

extension TimerInteractor: TimerBusinessLogic {
    func startTimer() {
        if sleepTimerIsOn {
            sleepTimerIsOn = false
            timer.invalidate()
            presenter?.updateTimerButton(status: .resume)
            presenter?.switchPickerInteraction()
        } else {
            sleepTimerIsOn = true
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(startCountdown),
                                         userInfo: nil,
                                         repeats: true)
            presenter?.updateTimerButton(status: .pause)
            presenter?.switchPickerInteraction()
        }
    }
}

// MARK: - Private Methods

private extension TimerInteractor {
    @objc
    func startCountdown() {
        if TimerViewModel.pickerSeconds >= 0 {
            let minutes = String(format: "%02d", TimerViewModel.pickerSeconds / 60)
            let seconds = String(format: "%02d", TimerViewModel.pickerSeconds % 60)
            let timerLabelText = minutes + ":" + seconds
            TimerViewModel.pickerSeconds -= 1
            presenter?.updateTimerLabel(with: timerLabelText)
        }
        if TimerViewModel.pickerSeconds < 0 {
            sleepTimerIsOn = false
            timer.invalidate()
            notification.post(name: Notification.Name("PauseMusic"), object: nil)
            presenter?.updateTimerButton(status: .chilling)
            print("Countdown has ended. Radio paused.")
        }
    }
}

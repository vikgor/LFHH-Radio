//
//  TimerInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol TimerBusinessLogic {
    func startCountdown()
    func startTimer()
}

final class TimerInteractor {
    
    var presenter: TimerPresentationLogic?
    
    var viewModel = TimerViewModel()
    
    var timer = Timer()
    var sleepTimerIsOn = false
    let notification = NotificationCenter.default
    
}

// MARK: - TimerBusinessLogic

extension TimerInteractor: TimerBusinessLogic {
    @objc
    func startCountdown() {
        print(viewModel.pickerSeconds)
        if viewModel.pickerSeconds >= 0 {
            let minutes = String(format: "%02d", viewModel.pickerSeconds / 60)
            let seconds = String(format: "%02d", viewModel.pickerSeconds % 60)
            let timerLabelText = minutes + ":" + seconds
            viewModel.pickerSeconds -= 1
            presenter?.setTimerLabelText(string: timerLabelText)
        }
        if viewModel.pickerSeconds < 0 {
            sleepTimerIsOn = false
            print("Countdown has ended. Radio paused.")
            notification.post(name: Notification.Name("PauseMusic"), object: nil)
            timer.invalidate()
            presenter?.setTimerButtonChilling()
        }
    }
    
    func startTimer() {
        if sleepTimerIsOn {
            timer.invalidate()
            sleepTimerIsOn = false
            presenter?.setTimerButtonResume()
            presenter?.switchPickerInteraction()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
            sleepTimerIsOn = true
            presenter?.setTimerButtonPause()
            presenter?.switchPickerInteraction()
        }
    }
}

// MARK: - Private Methods

private extension TimerInteractor {
    
}

//
//  TimerPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/24/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation

class TimerPresenter {
    
    weak var viewController: TimerViewController?
    
    func setTimerLabelText(string: String) {
        viewController?.setTimerLabelText(string: string)
    }
    
    func setTimerButtonTitle(string: String) {
        viewController?.setTimerButtonTitle(string: string)
    }
    
    func setTimerButtonChilling() {
        setTimerButtonTitle(string: "Chilling...")
    }
    
    func setTimerButtonResume() {
        setTimerButtonTitle(string: "Resume")
    }
    
    func setTimerButtonPause() {
        setTimerButtonTitle(string: "Pause")
    }
    
    func switchPickerInteraction() {
        viewController?.sleepTimerMinutes.isUserInteractionEnabled.toggle()
    }
    
}

//
//  TimerPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol TimerPresentationLogic {
    func setTimerLabelText(string: String)
    func setTimerButtonTitle(string: String)
    func setTimerButtonChilling()
    func setTimerButtonResume()
    func setTimerButtonPause()
    func switchPickerInteraction()
}

final class TimerPresenter {
    
    weak var viewController: TimerDisplayLogic?
    
}

// MARK: - TimerPresentationLogic

extension TimerPresenter: TimerPresentationLogic {
    
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
        viewController?.toggleUserInteractions()
    }
}

// MARK: - Private Methods

private extension TimerPresenter {
    
}

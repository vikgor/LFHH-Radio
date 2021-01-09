//
//  TimerPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol TimerPresentationLogic {
    func updateTimerLabel(with string: String)
    func updateTimerButton(status: ChillStatus)
    func switchPickerInteraction()
}

final class TimerPresenter {
    
    weak var viewController: TimerDisplayLogic?
    
}

// MARK: - TimerPresentationLogic

extension TimerPresenter: TimerPresentationLogic {
    
    func updateTimerLabel(with string: String) {
        viewController?.setTimerLabelText(string)
    }
    
    func updateTimerButton(status: ChillStatus) {
        viewController?.setTimerButtonTitle(status.rawValue)
    }
    
    func switchPickerInteraction() {
        viewController?.toggleUserInteractions()
    }
}

// MARK: - Private Methods

private extension TimerPresenter {
    
}

//
//  TimerViewModel.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

struct TimerViewModel {
    let pickerData: [(label: String, seconds: Int)] = [
        ("1 minute"   , 60),
        ("5 minutes"  , 300),
        ("10 minutes" , 600),
        ("15 minutes" , 900),
        ("30 minutes" , 1800),
        ("45 minutes" , 2400),
        ("1 hour"     , 3600)
    ]
    static var pickerSeconds = 60
    static let chillLabel = "Chill..."
}

enum ChillStatus: String {
    case chilling = "Chilling..."
    case resume = "Resume"
    case pause = "Pause"
}

//
//  TimerViewModel.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

struct TimerViewModel {
    var pickerData = ["1 minute", "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour",]
    var pickerMinutes: [Int] = [60, 300, 600, 900, 1800, 2400, 3600]
    var pickerSeconds = 60
}

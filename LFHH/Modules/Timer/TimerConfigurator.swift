//
//  TimerConfigurator.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

final class TimerConfigurator {
    
    static let shared = TimerConfigurator()
    private init() {}

    func configure(_ viewController: TimerViewController) {
        let interactor = TimerInteractor()
        let presenter = TimerPresenter()
        let router = TimerRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController
        
        router.viewController = viewController
    }
    
}

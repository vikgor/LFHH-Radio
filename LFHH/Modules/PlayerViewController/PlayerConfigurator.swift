//
//  PlayerConfigurator.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

final class PlayerConfigurator {
    
    static let shared = PlayerConfigurator()
    private init() {}

    func configure(_ viewController: PlayerViewController) {
        let interactor = PlayerInteractor()
        let presenter = PlayerPresenter()
        let router = PlayerRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController
        
        router.viewController = viewController
    }
    
}

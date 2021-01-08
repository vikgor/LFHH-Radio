//
//  PlaylistConfigurator.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

final class PlaylistConfigurator {
    
    static let shared = PlaylistConfigurator()
    private init() {}

    func configure(_ viewController: PlaylistViewController) {
        let interactor = PlaylistInteractor()
        let presenter = PlaylistPresenter()
        let router = PlaylistRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController
        
        router.viewController = viewController
    }
    
}

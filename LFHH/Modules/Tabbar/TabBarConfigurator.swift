//
//  TabBarConfigurator.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

final class TabBarConfigurator {

    static func configure(_ viewController: TabBarViewController) {
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter()

        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController
    }
}

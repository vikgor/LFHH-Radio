//
//  PlaylistPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol PlaylistPresentationLogic {
    func presentRefresh()
}

final class PlaylistPresenter {
    
    weak var viewController: PlaylistDisplayLogic?
    
}

// MARK: - PlaylistPresentationLogic

extension PlaylistPresenter: PlaylistPresentationLogic {
    func presentRefresh() {
        viewController?.reloadData()
        viewController?.endRefreshing()
    }
}

// MARK: - Private Methods

private extension PlaylistPresenter {
    
}

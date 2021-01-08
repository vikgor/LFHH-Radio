//
//  PlayerPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol PlayerPresentationLogic {
    func updatePlayback(playerStatus: PlayerStatus, trackTitle: String?)
    func presentInfoCenter(with currentlyPlaying: CurrentSong)
}

final class PlayerPresenter {
    
    weak var viewController: PlayerDisplayLogic?
    
}

// MARK: - PlayerPresentationLogic

extension PlayerPresenter: PlayerPresentationLogic {
    
    func updatePlayback(playerStatus: PlayerStatus, trackTitle: String?) {
        viewController?.updatePlayback(playerStatus: playerStatus, trackTitle: trackTitle)
    }
    
    func presentInfoCenter(with currentlyPlaying: CurrentSong) {
        viewController?.displayInfoCenter(with: currentlyPlaying)
    }
    
}

// MARK: - Private Methods

private extension PlayerPresenter {
    
}

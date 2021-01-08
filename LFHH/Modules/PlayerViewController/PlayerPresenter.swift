//
//  PlayerPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation
import MediaPlayer

protocol PlayerPresentationLogic {
    func presentPlayer()
    func resumePlayback(playerItem: AVPlayerItem)
    func pausePlayback()
    func updateMainLabelFromPresenter(trackTitle: String)
}

final class PlayerPresenter {
    
    weak var viewController: PlayerDisplayLogic?
    
}

// MARK: - PlayerPresentationLogic

extension PlayerPresenter: PlayerPresentationLogic {
    
    func updateMainLabelFromPresenter(trackTitle: String) {
        viewController?.updateMainLabel(trackTitle: trackTitle)
    }
    func presentPlayer() {
        viewController?.updateMainLabel(trackTitle: "Press Play...")
    }
    
    func resumePlayback(playerItem: AVPlayerItem) {
        viewController?.resumePlayback(playerItem: playerItem)
        viewController?.updateMainLabel(trackTitle: "connecting...")
    }
    
    func pausePlayback() {
        viewController?.pausePlayback()
        viewController?.updateMainLabel(trackTitle: "Paused...")
    }
}

// MARK: - Private Methods

private extension PlayerPresenter {
    
}

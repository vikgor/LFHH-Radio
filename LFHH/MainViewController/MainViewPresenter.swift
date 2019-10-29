//
//  MainViewPresenter.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/21/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation
import MediaPlayer

class MainViewPresenter {
    
    weak var viewController: MainViewController?
    
    var playImage = UIImage(named: "play-button-white")
    var pauseImage = UIImage(named: "pause-button-white")
    
    func startDoingStuff() {
        updateMainLabelFromPresenter(trackTitle: "Press Play...")
    }
    
    func updateMainLabelFromPresenter(trackTitle: String) {
        viewController?.updateMainLabel(trackTitle: trackTitle)
    }
    
    func setButtonImageFromPresenter(image: UIImage) {
        viewController?.setButtonImage(image: image)
    }
    
    func resumePlayback(playerItem: AVPlayerItem) {
        setButtonImageFromPresenter(image: pauseImage!)
        updateMainLabelFromPresenter(trackTitle: "connecting...")
        print("It's playing")
    }
    
    func pausePlayback() {
        setButtonImageFromPresenter(image: playImage!)
        updateMainLabelFromPresenter(trackTitle: "Paused...")
        print("It's NOT playing")
    }
    
}

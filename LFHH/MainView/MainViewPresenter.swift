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
    
    var viewController: ViewController?
    
    var radioPlayer = AVPlayer()
    var playImage = UIImage(named: "play-button-white")
    var pauseImage = UIImage(named: "pause-button-white")
    
    func startDoingStuff() {
        updateMainLabelFromPresenter(trackTitle: "Press Play...")
        setupRemoteTransportControls()
    }
    
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [unowned self] event in
            self.radioPlayer.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            self.radioPlayer.pause()
            return .success
        }
    }
    
    func updateMainLabelFromPresenter(trackTitle: String) {
        viewController?.updateMainLabel(trackTitle: trackTitle)
    }
    
    func setButtonImageFromPresenter(image: UIImage) {
        viewController?.setButtonImage(image: image)
    }
    
}

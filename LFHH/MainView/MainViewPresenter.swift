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
        //FIX THIS
        updateMainLabelFromPresenter(trackTitle: "Text from Presenter")
//        viewController?.updateMainLabel(trackTitle: "Maybe this??")
        
        
        setupRemoteTransportControls()
    }
    
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            self.radioPlayer.play()
            return .success
        }
           
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            self.radioPlayer.pause()
            return .success
        }
    }
    
    
    func updateMainLabelFromPresenter(trackTitle: String) {
        viewController?.updateMainLabel(trackTitle: trackTitle)
        
    }
    
}

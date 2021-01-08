//
//  PlayerInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

protocol PlayerBusinessLogic {
    func preparePlayer()
    func resumePlayback()
    func pausePlayback()
}

final class PlayerInteractor: NSObject {
    
    var presenter: PlayerPresentationLogic?
    var currentlyPlaying = CurrentSong(fileName: "", track: "", artist: "")
    var playerItem: AVPlayerItem!
    var radioPlayer = AVPlayer()
    var isPlaying = false
    let numberOfPartsInFileName = 1
    let timerObserver = NotificationCenter.default
//    let playBackURL = URL(string: "https://vivalaresistance.ru/streamlofi")
    let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
//    let playBackURL = URL(string: "http://62.109.25.83:8000/radio")   //checking offline mode
    
    func preparePlayer() {
        makeAudioWorkInBackground()
        setupRemoteTransportControls()
        presenter?.presentPlayer()
        timerObserver.addObserver(self, selector: #selector(pausePlayback), name: Notification.Name("PauseMusic"), object: nil)
    }
    
    func makeAudioWorkInBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,
                                                            mode: .default,
                                                            options: [.allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
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
    
    //Observe metadata
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "timedMetadata" else { return }
        guard let meta = playerItem.timedMetadata else { return }
        for metadata in meta {
            if let originalFileName = metadata.value(forKey: "value") as? String {
                print(originalFileName)
                checkIfAlive(originalFileName: originalFileName)
                splitFileNameIntoArtistAndTrack(string: originalFileName)
                setupInfoCenter()
                presenter?.updateMainLabelFromPresenter(trackTitle: makeFullSongName(source: currentlyPlaying))
                print("New song much?\nFile name: \(originalFileName)\nArtist: \(currentlyPlaying.artist)\nTrack: \(currentlyPlaying.track)")
            }
        }
    }

    //See if the radio is online by checking the metadata
    func checkIfAlive(originalFileName: String) {
        if (originalFileName == ("Lavf56.15.102") || originalFileName == ("B4A7D6322MH1376302278118826")) {
            currentlyPlaying = CurrentSong(fileName: "Offline... stay tuned!", track: "stay tuned...", artist: "LFHH is offline")
        }
    }
    
    func splitFileNameIntoArtistAndTrack(string: String) {
        var stringParts = [String]()
        if string.range(of: " - ") != nil {
            stringParts = string.components(separatedBy: " - ")
        } else {
            stringParts = string.components(separatedBy: "-")
        }
        
        if stringParts.count > numberOfPartsInFileName {
            //TODO: - may crash if name format isn't "aaa - bbb.mp3"
            currentlyPlaying = CurrentSong(fileName: nil,
                                           track: stringParts[1],
                                           artist: stringParts[0])
        }
    }
    
    func makeFullSongName(source: CurrentSong) -> String{
         return "\(source.artist) - \(source.track)"
    }
    
    func setupInfoCenter() {
        let image = UIImage(named: "lofinight")!
        let albumArt = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPNowPlayingInfoPropertyIsLiveStream: true,
            MPMediaItemPropertyArtist: currentlyPlaying.artist,
            MPMediaItemPropertyTitle: currentlyPlaying.track,
            MPMediaItemPropertyArtwork: albumArt
        ]
    }
    
    func resumePlayback() {
        isPlaying.toggle()
        playerItem = AVPlayerItem(url: playBackURL!)
        presenter?.resumePlayback(playerItem: playerItem)
        radioPlayer = AVPlayer(playerItem: playerItem)
        radioPlayer.play()
        let playerItem = radioPlayer.currentItem
        playerItem?.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        
    }
    
    @objc
    func pausePlayback() {
        if isPlaying == true {
            isPlaying.toggle()
            radioPlayer.pause()
            presenter?.pausePlayback()
            radioPlayer.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
        }
    }
    
}

// MARK: - PlayerBusinessLogic

extension PlayerInteractor: PlayerBusinessLogic {
    
}

// MARK: - Private Methods

private extension PlayerInteractor {
    
}

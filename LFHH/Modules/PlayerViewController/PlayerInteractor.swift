//
//  PlayerInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

protocol PlayerBusinessLogic {
    func updatePlayback(playerStatus: PlayerStatus)
}

final class PlayerInteractor: NSObject {
    
    var presenter: PlayerPresentationLogic?
    
    private var currentlyPlaying = CurrentSong(fileName: "", track: "", artist: "")
    private var playerItem: AVPlayerItem!
    private var radioPlayer = AVPlayer()
    private var playerStatus: PlayerStatus = .notPlaying
    private let timerObserver = NotificationCenter.default
    
    // Observe metadata
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard keyPath == "timedMetadata" else {
            return
        }
        guard let meta = playerItem.timedMetadata else {
            return
        }
        for metadata in meta {
            if let originalFileName = metadata.value(forKey: "value") as? String {
                checkIfAlive(originalFileName)
                currentlyPlaying.splitFileNameIntoArtistAndTrack(from: originalFileName)
                updateInfoCenter()
                presenter?.updatePlayback(playerStatus: .notPlaying, trackTitle: currentlyPlaying.makeFullSongName())
                
                print("New song much?\nFile name: \(originalFileName)\nArtist: \(currentlyPlaying.artist)\nTrack: \(currentlyPlaying.track)")
            }
        }
    }
    
}

// MARK: - PlayerBusinessLogic

extension PlayerInteractor: PlayerBusinessLogic {
    func updatePlayback(playerStatus: PlayerStatus) {
        switch playerStatus {
        case .notPlaying:
            preparePlayer()
        case .playing:
            resumePlayback()
        case .paused:
            pausePlayback()
        }
    }
}

// MARK: - Private Methods

private extension PlayerInteractor {
    
    func preparePlayer() {
        makeAudioWorkInBackground()
        setupRemoteTransportControls()
        presenter?.updatePlayback(playerStatus: .notPlaying, trackTitle: nil)
        timerObserver.addObserver(self,
                                  selector: #selector(pausePlayback),
                                  name: Notification.Name("PauseMusic"), object: nil)
    }
    
    func resumePlayback() {
        playerStatus = .playing
        guard let url = PlayerViewModel.streamUrl else {
            return
        }
        playerItem = AVPlayerItem(url: url)
        presenter?.updatePlayback(playerStatus: .playing, trackTitle: nil)
        radioPlayer = AVPlayer(playerItem: playerItem)
        radioPlayer.play()
        let playerItem = radioPlayer.currentItem
        playerItem?.addObserver(self,
                                forKeyPath: "timedMetadata",
                                options: NSKeyValueObservingOptions(), context: nil)
    }
    
    @objc
    func pausePlayback() {
        if playerStatus == .playing {
            playerStatus = .paused
            radioPlayer.pause()
            presenter?.updatePlayback(playerStatus: .paused, trackTitle: nil)
            radioPlayer.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
        }
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
    
    /// Check if the radio is online by comparing the metadata
    func checkIfAlive(_ originalFileName: String) {
        if (originalFileName == (PlayerViewModel.icecastCheckString) || originalFileName == (PlayerViewModel.icecastCheckString2)) {
            currentlyPlaying = PlayerViewModel.offlineSong
        }
    }
    
    func updateInfoCenter() {
        presenter?.presentInfoCenter(with: currentlyPlaying)
    }
    
}

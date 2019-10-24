//
//  MainViewswift
//  LFHH
//
//  Created by Viktor Gordienko on 10/21/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

struct CurrentSong {
       var fileName : String?
       var track : String
       var artist : String
}

class MainViewInteractor {
    
    var presenter = MainViewPresenter()
    var currentlyPlaying = CurrentSong(fileName: "", track: "", artist: "")
//    var currentlyPlaying: CurrentSong?
//    I decided to go with empty variable instead because that way I won't get a warning: Expression implicitly coerced from 'String?' to 'Any'
    
    var isPlaying = false
    let numberOfPartsInFileName = 1
    let timerObserver = NotificationCenter.default
    let playBackURL = URL(string: "https://vivalaresistance.ru/streamlofi")
    //    let playBackURL = URL(string: "http://62.109.25.83:8000/radio")
    
    func startDoingStuff() {
        makeAudioWorkInBackground()
        timerObserver.addObserver(self, selector: #selector(pausePlayback), name: Notification.Name("PauseMusic"), object: nil)
        presenter.startDoingStuff()
    }
    
    func makeAudioWorkInBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func makeFullSongName(source: CurrentSong) -> String{
         return "\(source.artist) - \(source.track)"
    }
    
    func splitFileNameIntoArtistAndTrack(string: String) {
        var stringParts = [String]()
        if string.range(of: " - ") != nil {
            stringParts = string.components(separatedBy: " - ")
        } else {
            stringParts = string.components(separatedBy: "-")
        }
        
        if stringParts.count > numberOfPartsInFileName {
            currentlyPlaying = CurrentSong(track: stringParts[1], artist: stringParts[0])
        }
    }

    // MARK: Don't forget to check offline mode:
    func checkIfAlive(originalFileName: String) {
        //See if the radio is online by checking the metadata
        if (originalFileName == ("Lavf56.15.102") || originalFileName == ("B4A7D6322MH1376302278118826")) {
            currentlyPlaying = CurrentSong(fileName: "Offline... stay tuned!", track: "offline...", artist: "LFHH")
//            currentlyPlaying?.artist = "LFHH"
//            currentlyPlaying?.track = "offline..."
//            presenter.updateMainLabelFromPresenter(trackTitle: "Offline... stay tuned!")
        }
    }
    
    func setupNowPlaying() {
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
    
    
    // MARK: Fix observer
    //Observe - get metadata
    var playerItem: AVPlayerItem!
    
    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "timedMetadata" else { return }
        guard let meta = playerItem.timedMetadata else { return }
        for metadata in meta {
            if let originalFileName = metadata.value(forKey: "value") as? String {
                print(originalFileName)
                splitFileNameIntoArtistAndTrack(string: originalFileName)
                setupNowPlaying()
                presenter.updateMainLabelFromPresenter(trackTitle: makeFullSongName(source: currentlyPlaying))
                checkIfAlive(originalFileName: originalFileName)
                print("New song much?\nFile name: \(originalFileName)\nArtist: \(currentlyPlaying.artist)\nTrack: \(currentlyPlaying.track)")
            }
        }
    }
    //Resume the playback
    func resumePlayback() {
        isPlaying.toggle()
        playerItem = AVPlayerItem(url: playBackURL!)
        presenter.resumePlayback(playerItem: playerItem)
        
        //Oberver doesn't work yet!!!
//        let playerItem = presenter.radioPlayer.currentItem
//        playerItem?.addObserver(presenter.viewController!, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        
    }
    //Pause the playback
    @objc func pausePlayback() {
        if isPlaying == true {
            isPlaying.toggle()
            presenter.pausePlayback()
        
        //Oberver doesn't work yet!!!
//        presenter.radioPlayer.currentItem?.removeObserver(presenter.viewController!, forKeyPath: "timedMetadata")
        }
    }
    
}

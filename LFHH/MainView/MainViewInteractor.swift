//
//  MainViewInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/21/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

class MainViewInteractor {
    
    var presenter = MainViewPresenter()
    
    struct CurrentSong {
           var fileName : String?
           var track : String
           var artist : String
       }
    
    var currentlyPlaying = CurrentSong(fileName: "", track: "", artist: "")
    
    var isPlaying = false
    let playBackURL = URL(string: "http://62.109.25.83:8000/radio")
//    let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
    let numberOfPartsInFileName = 1
    let timerObserver = NotificationCenter.default
    
    func startDoingStuff() {
        
        timerObserver.addObserver(self, selector: #selector(ViewController.pausePlayback), name: Notification.Name("PauseMusic"), object: nil)
        
        //Make audio work in background
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
    }
    
    func checkIfAlive(originalFileName: String) {
        //See if the radio is online by checking the metadata
        if (originalFileName == ("Lavf56.15.102") || originalFileName == ("B4A7D6322MH1376302278118826")) {
            currentlyPlaying.artist = "LFHH"
            currentlyPlaying.track = "offline..."
            
            presenter.updateMainLabel2(trackTitle: "Offline... stay tuned!")
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
    
    // MARK: Use cases

    
    
    
    
}


/*
 
 -[] Get metadata
 -[] Break the file name apart into "Artist - Track"
 -[] Send the Artis-Track to Presenter (???)
 
 -[]

*/

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
//    let mainView = ViewController()
    
    struct CurrentSong {
           var fileName : String?
           var track : String
           var artist : String
       }
    
    var currentlyPlaying = CurrentSong(fileName: "", track: "", artist: "")
    
    var isPlaying = false
    let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
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
    
    
    
    
    // MARK: Use cases

    
    
    
    
}


/*
 
 -[] Get metadata
 -[] Break the file name apart into "Artist - Track"
 -[] Send the Artis-Track to Presenter (???)
 
 -[]

*/

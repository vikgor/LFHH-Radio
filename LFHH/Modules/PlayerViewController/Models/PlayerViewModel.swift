//
//  PlayerViewModel.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

struct PlayerViewModel {
    
    static let streamUrl = URL(string: "http://62.109.25.83:8000/lofi")
//    static let streamUrl = URL(string: "https://vivalaresistance.ru/streamlofi")
//    static let streamUrl = URL(string: "http://62.109.25.83:8000/radio")   //checking offline mode
    static let icecastCheckString = "Lavf56.15.102"
    static let icecastCheckString2 = "B4A7D6322MH1376302278118826"
    static let offlineSong = CurrentSong(fileName: "Offline... stay tuned!",
                                         track: "stay tuned...",
                                         artist: "LFHH is offline")
}

enum PlayerStatus: String {
    case notPlaying = "Press Play..."
    case playing = "connecting..."
    case paused = "Paused..."
}

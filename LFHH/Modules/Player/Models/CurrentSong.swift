//
//  CurrentSong.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/8/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

struct CurrentSong {
    var fileName: String?
    var track: String
    var artist: String
    
    let numberOfPartsInFileName = 1
    
    mutating func splitFileNameIntoArtistAndTrack(from string: String) {
        var stringParts = [String]()
        if string.range(of: " - ") != nil {
            stringParts = string.components(separatedBy: " - ")
        } else {
            stringParts = string.components(separatedBy: "-")
        }
        
        if stringParts.count > numberOfPartsInFileName {
            //TODO: - may crash if name format isn't "aaa - bbb.mp3"
            self.fileName = nil
            self.artist = stringParts[0]
            self.track = stringParts[1]
        }
    }
    
    func makeFullSongName() -> String{
        return "\(self.artist) - \(self.track)"
    }
}

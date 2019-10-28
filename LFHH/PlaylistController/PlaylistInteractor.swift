//
//  PlaylistInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 10/27/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import Foundation

class PlaylistInteractor {
    
    var presenter: PlaylistPresenter?
    

//    let myURLString = "https://8137147.xyz/1/playlist/playlist.php"
    let myURLString = "https://vivalaresistance.ru/lfhh/lfhhhistory.php"
    
    var historyArray: [String.SubSequence]?
    
    
    func startDoingStuff() {
        presenter?.startDoingStuff()
    }
    
    
    
    func getRadioPlaylist() {
        guard let myURL = NSURL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL as URL, encoding: .windowsCP1251) //the actual playlist, in text format
            historyArray = myHTMLString.split {$0.isNewline} //playlist, converted to an array
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
}

//
//  PlaylistInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol PlaylistBusinessLogic {
    func preparePlaylist()
    func getRadioPlaylist()
}

final class PlaylistInteractor {
    
    var presenter: PlaylistPresentationLogic?
    
}

// MARK: - PlaylistBusinessLogic

extension PlaylistInteractor: PlaylistBusinessLogic {
    func preparePlaylist() {
        getRadioPlaylist()
    }
    
    func getRadioPlaylist() {
        guard let myURL = NSURL(string: PlaylistViewModel.myURLString) else {
            print("Error: \(PlaylistViewModel.myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL as URL, encoding: .windowsCP1251) //playlist in text format
            PlaylistViewModel.historyArray = myHTMLString.split {$0.isNewline} //playlist -> array
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        presenter?.presentRefresh()
    }
}

// MARK: - Private Methods

private extension PlaylistInteractor {
    
}

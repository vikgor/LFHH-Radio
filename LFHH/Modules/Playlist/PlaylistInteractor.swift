//
//  PlaylistInteractor.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import Foundation

protocol PlaylistBusinessLogic {
    func startDoingStuff()
    func getRadioPlaylist()
}

final class PlaylistInteractor {
    
    var presenter: PlaylistPresentationLogic?
    
    var viewModel = PlaylistViewModel()
    
//    let myURLString = "https://vivalaresistance.ru/lfhh/lfhhhistory.php"
//    let myURLString = "https://vivalaresistance.ru/radio/stuff/vlrradiobot.php?type=getLofiPlaylist"
//    var historyArray: [String.SubSequence]?
////    Why did I do this??
//    var historyArray: [String.SubSequence]? {
//        didSet {
//            tableView.reloadData()
//
//        }
//    }
}

// MARK: - PlaylistBusinessLogic

extension PlaylistInteractor: PlaylistBusinessLogic {
    func startDoingStuff() {
        getRadioPlaylist()
    }
    
    func getRadioPlaylist() {
        guard let myURL = NSURL(string: viewModel.myURLString) else {
            print("Error: \(viewModel.myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL as URL, encoding: .windowsCP1251) //playlist in text format
            PlaylistViewModel.historyArray = myHTMLString.split {$0.isNewline} //playlist -> array
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        presenter?.refresh()
    }
}

// MARK: - Private Methods

private extension PlaylistInteractor {
    
}

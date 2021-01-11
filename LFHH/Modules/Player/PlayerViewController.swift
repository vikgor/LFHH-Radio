//
//  PlayerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

protocol PlayerDisplayLogic: class {
    func updatePlayback(playerStatus: PlayerStatus, trackArtist: String?, trackTitle: String?)
    func displayInfoCenter(with currentlyPlaying: CurrentSong)
}

final class PlayerViewController: UIViewController {
    
    @IBOutlet private weak var radioButton: UIButton!
    @IBOutlet private weak var trackArtistLabel: UILabel!
    @IBOutlet private weak var trackTitleLabel: UILabel!
    @IBOutlet private weak var volumeView: MPVolumeView!
    
    @IBAction private func playRadio(_ sender: UIButton) {
        isPlaying ? interactor?.updatePlayback(playerStatus: .paused) : interactor?.updatePlayback(playerStatus: .playing)
        isPlaying.toggle()
    }
    
    private var isPlaying = false
    
    var interactor: PlayerBusinessLogic?
    var router: PlayerRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        PlayerConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PlayerConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.updatePlayback(playerStatus: .notPlaying)
        setupSubviews()
    }
    
}

// MARK: - PlayerDisplayLogic

extension PlayerViewController: PlayerDisplayLogic {
    
    func updatePlayback(playerStatus: PlayerStatus, trackArtist: String?, trackTitle: String?) {
        trackArtistLabel.text = (trackArtist != nil) ? trackArtist : playerStatus.rawValue
        trackTitleLabel.text = trackTitle
        
        switch playerStatus {
        case .notPlaying:
            break
        case .playing:
            radioButton.setImage(#imageLiteral(resourceName: "pause-button-white"), for: .normal)
        case .paused:
            radioButton.setImage(#imageLiteral(resourceName: "play-button-white"), for: .normal)
        }
    }
    
    func displayInfoCenter(with currentlyPlaying: CurrentSong) {
        let image = #imageLiteral(resourceName: "logo")
        let albumArt = MPMediaItemArtwork.init(boundsSize: image.size,
                                               requestHandler: { (size) -> UIImage in
                                                return image
                                               })
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPNowPlayingInfoPropertyIsLiveStream: true,
            MPMediaItemPropertyArtist: currentlyPlaying.artist,
            MPMediaItemPropertyTitle: currentlyPlaying.track,
            MPMediaItemPropertyArtwork: albumArt
        ]
    }
}

// MARK: - Private Methods

private extension PlayerViewController {
    
    func setupSubviews() {
        addVolumeControls()
    }
    
    func addVolumeControls() {
        volumeView.backgroundColor = .clear
        volumeView.showsRouteButton = true
        volumeView.tintColor = UIColor(named: "yellow")
    }
    
}

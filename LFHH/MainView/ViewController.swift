//
//  ViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 6/30/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var mpVolumeHolderView: UIView!
    
    var interactor: MainViewInteractor = MainViewInteractor()
    var presenter: MainViewPresenter = MainViewPresenter()
    
    func build() {
        let interactor = MainViewInteractor()
        self.interactor = interactor
        let presenter = MainViewPresenter()
        interactor.presenter = presenter
//        presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        build()
        
        interactor.startDoingStuff()
        
        presenter.setupRemoteTransportControls()
        setButtonImage(image: presenter.playImage!)
        
        changeTrackTitle(title: "Press Play...")
        addVolumeControls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: INTERACTOR
    //Observe - get metadata
    var playerItem: AVPlayerItem!
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "timedMetadata" else { return }
        guard let meta = playerItem.timedMetadata else { return }
        for metadata in meta {
            if let songName = metadata.value(forKey: "value") as? String {
                
                trackTitleLabel.text = songName
                
                checkIfAlive(songName: songName)
                splitFileNameIntoArtistAndTrack(songName: songName)
                setupNowPlaying()
                
                print("NEW SONG")
                print("File name: \(songName)")
                print("Artist: \(interactor.currentlyPlaying.artist)")
                print("Track: \(interactor.currentlyPlaying.track)")
                
            }
        }
    }
    
    func splitFileNameIntoArtistAndTrack(songName: String) {
        // Split artist and track into seperate strings
        interactor.currentlyPlaying.fileName = songName
        var stringParts = [String]()
        if interactor.currentlyPlaying.fileName?.range(of: " - ") != nil {
            stringParts = interactor.currentlyPlaying.fileName!.components(separatedBy: " - ")
        } else {
            stringParts = interactor.currentlyPlaying.fileName!.components(separatedBy: "-")
        }
        
        if stringParts.count > interactor.numberOfPartsInFileName {
            interactor.currentlyPlaying.artist = stringParts[0]
            interactor.currentlyPlaying.track = stringParts[1]
        }
    }
    
    func checkIfAlive(songName: String) {
        //See if the radio is online by checking the metadata
        if songName == "Lavf56.15.102" {
            trackTitleLabel.text = "Offline... stay tuned!"
            interactor.currentlyPlaying.artist = "LFHH"
            interactor.currentlyPlaying.track = "offline..."
        }
    }
    
    func setupNowPlaying() {
        let image = UIImage(named: "lofinight")!
        let albumArt = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPNowPlayingInfoPropertyIsLiveStream: true,
            MPMediaItemPropertyArtist: interactor.currentlyPlaying.artist,
            MPMediaItemPropertyTitle: interactor.currentlyPlaying.track,
            MPMediaItemPropertyArtwork: albumArt
        ]
    }
    // MARK: INTERACTOR ends here
    
    
    
   // MARK: PRESENTER
    func changeTrackTitle(title: String) {
        trackTitleLabel.text = title
    }
    
    func setButtonImage(image: UIImage) {
        radioButton.setImage(image, for: .normal)
    }
    
    func addVolumeControls() {
        // MPVolumeView (This adds volume control to the Main View)
        mpVolumeHolderView.backgroundColor = .clear
        let mpVolume = MPVolumeView(frame: mpVolumeHolderView.bounds)
        mpVolume.showsRouteButton = true
        mpVolumeHolderView.addSubview(mpVolume)
        view.addSubview(mpVolumeHolderView)
    }
    
    
    func resumePlayback() {
        interactor.isPlaying.toggle()
        radioButton.setImage(presenter.pauseImage, for: .normal)
        playerItem = AVPlayerItem(url: interactor.playBackURL!)
        presenter.radioPlayer = AVPlayer(playerItem: playerItem)
        presenter.radioPlayer.play()
        let playerItem = presenter.radioPlayer.currentItem
        playerItem?.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        trackTitleLabel.text = "connecting..."
    }
    
    //Pause the playback
    @objc func pausePlayback() {
        if interactor.isPlaying == true {
        interactor.isPlaying.toggle()
        presenter.radioPlayer.pause()
        presenter.radioPlayer.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
        trackTitleLabel.text = "Paused..."
        radioButton.setImage(presenter.playImage, for: .normal)
        }
    }

    @IBAction func playRadio(_ sender: UIButton) {
        switch interactor.isPlaying {
        case false:
            resumePlayback()
            print("It's playing")
        default:
            pausePlayback()
            print("It's NOT playing")
        }
    }
    
    // MARK: PRESENTER ends here
}

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
    
    func setup() {
        let interactor = MainViewInteractor()
        self.interactor = interactor
        let presenter = MainViewPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.startDoingStuff()
        addVolumeControls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UI
    func addVolumeControls() {
        // MPVolumeView
        mpVolumeHolderView.backgroundColor = .clear
        let mpVolume = MPVolumeView(frame: mpVolumeHolderView.bounds)
        mpVolume.showsRouteButton = true
        mpVolumeHolderView.addSubview(mpVolume)
        view.addSubview(mpVolumeHolderView)
    }
    
    func updateMainLabel(trackTitle: String) {
        trackTitleLabel.text = trackTitle
    }

    func setButtonImage(image: UIImage) {
        radioButton.setImage(image, for: .normal)
    }
    // MARK: UI
    
    
    
    
    
    
    // MARK: INTERACTOR
//    //Observe - get metadata
//    var playerItem: AVPlayerItem!
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        guard keyPath == "timedMetadata" else { return }
//        guard let meta = playerItem.timedMetadata else { return }
//        for metadata in meta {
//            if let originalFileName = metadata.value(forKey: "value") as? String {
//                
//                interactor.splitFileNameIntoArtistAndTrack(originalFileName: originalFileName)
//                interactor.setupNowPlaying()
//                
//                updateMainLabel(trackTitle: originalFileName)
//                interactor.checkIfAlive(originalFileName: originalFileName)
//                
//                print("New song much?\nFile name: \(originalFileName)\nArtist: \(interactor.currentlyPlaying.artist)\nTrack: \(interactor.currentlyPlaying.track)")
//            }
//        }
//    }
//    //Resume the playback
//    func resumePlayback() {
//        interactor.isPlaying.toggle()
//        playerItem = AVPlayerItem(url: interactor.playBackURL!)
//        presenter.radioPlayer = AVPlayer(playerItem: playerItem)
//        presenter.radioPlayer.play()
//        let playerItem = presenter.radioPlayer.currentItem
//        playerItem?.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
//        setButtonImage(image: presenter.pauseImage!)
//        updateMainLabel(trackTitle: "connecting...")
//        print("It's playing")
//    }
//    //Pause the playback
//    @objc func pausePlayback() {
//        if interactor.isPlaying == true {
//        interactor.isPlaying.toggle()
//        presenter.radioPlayer.pause()
//        presenter.radioPlayer.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
//        setButtonImage(image: presenter.playImage!)
//        updateMainLabel(trackTitle: "Paused...")
//        print("It's NOT playing")
//        }
//    }
    // MARK: INTERACTOR stuff ends here
    
    @IBAction func playRadio(_ sender: UIButton) {
        switch interactor.isPlaying {
        case false:
            interactor.resumePlayback()
        default:
            interactor.pausePlayback()
        }
    }
    
}

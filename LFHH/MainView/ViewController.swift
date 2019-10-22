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
    var presenter: MainViewPresenter = MainViewPresenter() //This works now, but I won't need this line after I move some functions to the Presenter
    
    func build() {
        let interactor = MainViewInteractor()
        self.interactor = interactor
        let presenter = MainViewPresenter()
        interactor.presenter = presenter
//        presenter.view = self //How do I manage to link VC to Presenter?????
        
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
            if let originalFileName = metadata.value(forKey: "value") as? String {
                
                interactor.splitFileNameIntoArtistAndTrack(originalFileName: originalFileName)
                interactor.setupNowPlaying()
                
                print("New song much?")
                print("File name: \(originalFileName)")
                print("Artist: \(interactor.currentlyPlaying.artist)")
                print("Track: \(interactor.currentlyPlaying.track)")
                
                updateMainLabel(trackTitle: originalFileName)
                interactor.checkIfAlive(originalFileName: originalFileName)

            }
        }
    }
    
    // MARK: INTERACTOR ends here
    
    func updateMainLabel(trackTitle: String) {
        trackTitleLabel.text = trackTitle
    }
    
    func changeTrackTitle(title: String) {
        trackTitleLabel.text = title
    }
    
    func setButtonImage(image: UIImage) {
        radioButton.setImage(image, for: .normal)
    }

    // MARK: PRESENTER
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
        updateMainLabel(trackTitle: "connecting...")
    }
    
    //Pause the playback
    @objc func pausePlayback() {
        if interactor.isPlaying == true {
        interactor.isPlaying.toggle()
        presenter.radioPlayer.pause()
        presenter.radioPlayer.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
        updateMainLabel(trackTitle: "Paused...")
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

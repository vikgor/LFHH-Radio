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
    
    var isPlaying = false
    var radioPlayer = AVPlayer()
    var playerItem: AVPlayerItem!
    
    let ncObserver = NotificationCenter.default
    
    var currentlyPlaying : String?
    var Track = ""
    var Artist = ""

    var playImage = UIImage(named: "play-button-white")
    var pauseImage = UIImage(named: "pause-button-white")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        radioButton.setTitle("Play", for: .normal)
        radioButton.setImage(playImage, for: .normal)
        
        trackTitleLabel.text = "Press Play..."
        
        setupRemoteTransportControls()
        
        
        //make audio work in background
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        // MPVolumeView
        // Set the holder view’s background color to transparent
        mpVolumeHolderView.backgroundColor = .clear
        let mpVolume = MPVolumeView(frame: mpVolumeHolderView.bounds)
        mpVolume.showsRouteButton = true
        mpVolumeHolderView.addSubview(mpVolume)
        view.addSubview(mpVolumeHolderView)
//        view.backgroundColor = .darkGray
        
        ncObserver.addObserver(self, selector: #selector(self.pausePlayback), name: Notification.Name("PauseMusic"), object: nil)
    }
    
    //Observe - get metadata
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "timedMetadata" else { return }
        guard let meta = playerItem.timedMetadata else { return }
        for metadata in meta {
            if let songName = metadata.value(forKey: "value") as? String {
                print("Now playing: \(songName)")
                trackTitleLabel.text = songName
                
                // Split artist and track into seperate strings
                currentlyPlaying = songName
                var stringParts = [String]()
                if currentlyPlaying?.range(of: " - ") != nil {
                    stringParts = currentlyPlaying!.components(separatedBy: " - ")
                } else {
                    stringParts = currentlyPlaying!.components(separatedBy: "-")
                }
                // Asigns artist and track to variables
                if stringParts.count > 1 {
                    Track = stringParts[1]
                    Artist = stringParts[0]
                }
                print("The artist is \(Artist)")
                print("The track is \(Track)")
                
                //See if the radio is online by checking the metadata
                if songName == "Lavf56.15.102" {
                    trackTitleLabel.text = "Offline... stay tuned!"
                    Artist = "LFHH"
                    Track = "offline..."
                }
                
                setupNowPlaying()
            }
        }
    }
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            self.radioPlayer.play()
            return .success
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            self.radioPlayer.pause()
            return .success
        }
    }
    
    func setupNowPlaying() {
        let image = UIImage(named: "lofinight")!
        let albumArt = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPNowPlayingInfoPropertyIsLiveStream: true,
            MPMediaItemPropertyArtist: Artist,
            MPMediaItemPropertyTitle: Track,
            MPMediaItemPropertyArtwork: albumArt
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func resumePlayback() {
        isPlaying.toggle()
//        radioButton.setTitle("Stop", for: .normal)
        radioButton.setImage(pauseImage, for: .normal)
//        let playBackURL = "https://nashe1.hostingradio.ru:80/nashe-64.mp3"

//        let playBackURL = URL(string: "https://vivalaresistance.ru/streamradio")
        let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
        playerItem = AVPlayerItem(url: playBackURL!)
        radioPlayer = AVPlayer(playerItem: playerItem)
        radioPlayer.play()
        
        let playerItem = radioPlayer.currentItem
        playerItem?.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        
        trackTitleLabel.text = "connecting..."
    }
    
    //Pause the playback
    @objc func pausePlayback() {
        radioPlayer.pause()
        radioPlayer.currentItem!.removeObserver(self, forKeyPath: "timedMetadata")
        //        radioPlayer.allowsExternalPlayback = true
        
        trackTitleLabel.text = "Paused..."
        isPlaying.toggle()
//        radioButton.setTitle("Play", for: .normal)
        radioButton.setImage(playImage, for: .normal)
    }
    

    @IBAction func playRadio(_ sender: UIButton) {
        switch isPlaying {
        case false:
            resumePlayback()
            print("It's playing")
        default:
            pausePlayback()
            print("It's NOT playing")
        }
    }
    
    func stupid() {
        print("This stupid shit works")
    }
}

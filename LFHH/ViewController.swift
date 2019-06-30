//
//  ViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 6/30/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var trackTitleLabel: UILabel!
    
    var isPlaying = false
    var radioPlayer = AVPlayer()
    var playerItem: AVPlayerItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        radioButton.setTitle("Play", for: .normal)
        trackTitleLabel.text = "Connecting..."
        
//        let playBackURL = "https://nashe1.hostingradio.ru:80/nashe-64.mp3"
        let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
        playerItem = AVPlayerItem(url: playBackURL!)
        radioPlayer = AVPlayer(playerItem: playerItem)
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
//        radioPlayer.play()
    }
    
    
    //Pause the playback
    func pausePlayback() {
        radioPlayer.pause()
        radioPlayer.currentItem!.removeObserver(self, forKeyPath: "timedMetadata")
        radioPlayer.allowsExternalPlayback = true
        trackTitleLabel.text = "Paused..."
    }
    
    //Resume the playback
    func resumePlayback() {
        radioPlayer.play()
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        
        
    }
    
    override func observeValue(forKeyPath: String?, of: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if forKeyPath != "timedMetadata" { return }
        let data: AVPlayerItem = of as! AVPlayerItem
        for item in data.timedMetadata! {
            print(item.value!)
            trackTitleLabel.text = item.value! as? String
           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func playRadio(_ sender: UIButton) {
        switch isPlaying {
        case false:
            resumePlayback()
            isPlaying.toggle()
            print(isPlaying)
            radioButton.setTitle("Stop", for: .normal)
        default:
            pausePlayback()
            isPlaying.toggle()
            print(isPlaying)
            radioButton.setTitle("Play", for: .normal)
            
            
            
        }
    }
    
}


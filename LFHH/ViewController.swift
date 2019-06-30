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
    var isPlaying = false
    var radioPlayer = AVPlayer()
    var playerItem: AVPlayerItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        radioButton.setTitle("Play", for: .normal)
        
//        let playBackURL = "https://nashe1.hostingradio.ru:80/nashe-64.mp3"
        let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
        playerItem = AVPlayerItem(url: playBackURL!)
        radioPlayer = AVPlayer(playerItem: playerItem)
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
//        radioPlayer.play()


    }
    
    override func observeValue(forKeyPath: String?, of: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if forKeyPath != "timedMetadata" { return }
        let data: AVPlayerItem = of as! AVPlayerItem
        for item in data.timedMetadata! {
            print(item.value!)
        }
    }
    
    @IBAction func playRadio(_ sender: UIButton) {
        radioPlayer.play()
        
        switch isPlaying {
        case false:
            radioPlayer.play()
            isPlaying.toggle()
            print(isPlaying)
            radioButton.setTitle("Stop", for: .normal)
            
        default:
            radioPlayer.pause()
            isPlaying.toggle()
            print(isPlaying)
            radioButton.setTitle("Play", for: .normal)
        }
    }
    
    

}


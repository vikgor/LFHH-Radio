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
    }
    
    override func observeValue(forKeyPath: String?, of: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if forKeyPath != "timedMetadata" { return }
        let data: AVPlayerItem = (of as? AVPlayerItem)!
        for item in data.timedMetadata! {
            print(item.value!)
            trackTitleLabel.text = item.value as? String
            // Где-то тут ошибка в опционалах, надо решить
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func resumePlayback() {
        isPlaying.toggle()
        radioButton.setTitle("Stop", for: .normal)
//        let playBackURL = "https://nashe1.hostingradio.ru:80/nashe-64.mp3"
        let playBackURL = URL(string: "http://62.109.25.83:8000/lofi")
        playerItem = AVPlayerItem(url: playBackURL!)
        radioPlayer = AVPlayer(playerItem: playerItem)
        radioPlayer.play()
        
        let playerItem = radioPlayer.currentItem
        playerItem?.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        
    }
    
    //Pause the playback
    func pausePlayback() {
        radioPlayer.pause()
        radioPlayer.currentItem!.removeObserver(self, forKeyPath: "timedMetadata")
        //        radioPlayer.allowsExternalPlayback = true
        
        trackTitleLabel.text = "Paused..."
        isPlaying.toggle()
        radioButton.setTitle("Play", for: .normal)
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
    
}


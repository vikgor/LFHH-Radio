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
    func updateMainLabel(trackTitle: String)
    func resumePlayback(playerItem: AVPlayerItem)
    func pausePlayback()
}

final class PlayerViewController: UIViewController {
    
    @IBOutlet private weak var radioButton: UIButton!
    @IBOutlet private weak var trackTitleLabel: UILabel!
    @IBOutlet private weak var mpVolumeHolderView: UIView!
    
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
        
        interactor?.preparePlayer()
        setupSubviews()
    }
    
    @IBAction func playRadio(_ sender: UIButton) {
        switch isPlaying {
        case false:
            interactor?.resumePlayback()
        default:
            interactor?.pausePlayback()
        }
    }

}

// MARK: - PlayerDisplayLogic

extension PlayerViewController: PlayerDisplayLogic {
    func updateMainLabel(trackTitle: String) {
        trackTitleLabel.text = trackTitle
    }
    func resumePlayback(playerItem: AVPlayerItem) {
        radioButton.setImage(UIImage(named: "play-button-white"),
                             for: .normal)
    }
    
    func pausePlayback() {
        radioButton.setImage(UIImage(named: "pause-button-white"), for: .normal)
    }
}

// MARK: - Private Methods

private extension PlayerViewController {
    
    func setupSubviews() {
        addVolumeControls()
    }
    
    func addVolumeControls() {
        mpVolumeHolderView.backgroundColor = .clear
        let mpVolume = MPVolumeView(frame: mpVolumeHolderView.bounds)
        mpVolume.showsRouteButton = true
        mpVolumeHolderView.addSubview(mpVolume)
        view.addSubview(mpVolumeHolderView)
    }
    
}

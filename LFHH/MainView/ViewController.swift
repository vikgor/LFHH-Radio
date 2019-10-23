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
    
    func addVolumeControls() {
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
    
    @IBAction func playRadio(_ sender: UIButton) {
        switch interactor.isPlaying {
        case false:
            interactor.resumePlayback()
        default:
            interactor.pausePlayback()
        }
    }
    
}

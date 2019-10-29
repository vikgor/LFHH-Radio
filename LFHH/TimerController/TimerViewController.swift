//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 8/13/19.
//  Copyright © 2019 Viktor Gordienko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    @IBOutlet weak var sleepTimerMinutes: UIPickerView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBAction func timerButton(_ sender: Any) {
        interactor.startTimer()
    }
    
    var interactor: TimerInteractor = TimerInteractor()
    
    func setup() {
        let presenter = TimerPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        sleepTimerMinutes.delegate = self
        sleepTimerMinutes.dataSource = self
        setTimerButtonTitle(string: "Chill...")
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interactor.pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(interactor.pickerData[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(interactor.pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        interactor.pickerSeconds = interactor.pickerMinutes[row]
    }
    
    func setTimerLabelText(string: String) {
        labelTimer.text = string
    }
    func setTimerButtonTitle(string: String) {
        timerButton.setTitle(string, for: .normal)
    }
    
}

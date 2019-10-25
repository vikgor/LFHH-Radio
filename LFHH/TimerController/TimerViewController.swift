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
        interactor?.timerButton()
    }
    
    var interactor: TimerInteractor?
    
    func setup() {
        let interactor = TimerInteractor()
        self.interactor = interactor
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
    
    
//    var pickerData = ["1 minute", "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour"]
//    var pickerMinutes: [Int] = [60, 300, 600, 900, 1800, 2400, 3600] //In seconds for testing, change this later
//    var pickerSeconds = 60
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
        return interactor!.pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(pickerData[row])
        return String(interactor!.pickerData[row])
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        return NSAttributedString(string: String(pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return NSAttributedString(string: String(interactor!.pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        pickerSeconds = pickerMinutes[row]
        interactor!.pickerSeconds = interactor!.pickerMinutes[row]
    }
    
    //Меня смущает только 4кратный force unwrapping
    
    
    
    
    func setTimerLabelText(string: String) {
        labelTimer.text = string
    }
    func setTimerButtonTitle(string: String) {
        timerButton.setTitle(string, for: .normal)
    }
    
    
}

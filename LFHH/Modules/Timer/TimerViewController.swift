//
//  TimerViewController.swift
//  LFHH
//
//  Created by Viktor Gordienko on 1/7/21.
//  Copyright © 2021 Viktor Gordienko. All rights reserved.
//

import UIKit

protocol TimerDisplayLogic: class {
    func toggleUserInteractions()
    func setTimerLabelText(_ string: String)
    func setTimerButtonTitle(_ string: String)
}

final class TimerViewController: UIViewController {
    
    @IBOutlet private weak var sleepTimerMinutes: UIPickerView!
    @IBOutlet private weak var labelTimer: UILabel!
    @IBOutlet private weak var timerButton: UIButton!
    
    @IBAction private func timerButton(_ sender: Any) {
        interactor?.startTimer()
    }
    
    var interactor: TimerBusinessLogic?
    var router: TimerRoutingLogic?
    
    private var viewModel = TimerViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        TimerConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TimerConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
}

// MARK: - TimerDisplayLogic

extension TimerViewController: TimerDisplayLogic {
    func toggleUserInteractions() {
        sleepTimerMinutes.isUserInteractionEnabled.toggle()
    }
    
    func setTimerLabelText(_ string: String) {
        labelTimer.text = string
    }
    
    func setTimerButtonTitle(_ string: String) {
        timerButton.setTitle(string, for: .normal)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(viewModel.pickerData[row].label)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(viewModel.pickerData[row].label),
                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TimerViewModel.pickerSeconds = viewModel.pickerData[row].seconds
    }
}

// MARK: - Private Methods

private extension TimerViewController {
    func setupSubviews() {
        timerButton.tintColor = UIColor(named: "yellow")
        sleepTimerMinutes.delegate = self
        sleepTimerMinutes.dataSource = self
        setTimerButtonTitle(TimerViewModel.chillLabel)
    }
}

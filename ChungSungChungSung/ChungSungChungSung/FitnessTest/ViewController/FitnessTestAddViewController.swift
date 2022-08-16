//
//  FitnessTestAddViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/12.
//

import UIKit

class FitnessTestAddViewController: UIViewController {
    @IBOutlet weak var exerciseAndTestSegment: UISegmentedControl!
    @IBOutlet weak var runningSwitch: UISwitch!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var runningMinute: UITextField!
    @IBOutlet weak var runningSecond: UITextField!
    @IBOutlet weak var pushupSwitch: UISwitch!
    @IBOutlet weak var situpSwitch: UISwitch!
    @IBOutlet weak var pushupCount: UITextField!
    @IBOutlet weak var situpCount: UITextField!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "체력검정 기록"
        navigationController?.navigationBar.topItem?.backButtonTitle = "체력검정"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runningMinute.delegate = self
        pushupCount.delegate = self
        situpCount.delegate = self
        configureDatePicker()
    }
    
//    private func ActiveSwitch() {
//        runningSwitch.isOn = false
//        runningSwitch.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControlEvents.valueChanged)
//    }
    
    private func onClickSwitch(sender: UISwitch) {
        
    }
    
    private func configureDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ko-KR")
        dateTextField.inputView = self.datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(tapCancel))
        toolBar.setItems([cancelButton, flexible, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        dateTextField.resignFirstResponder()
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
    }
}

extension FitnessTestAddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = runningMinute.text else { return true }
        if string.isEmpty {
            return true
        } else {
            return text.count < 2
        }
//        guard let text = pushupCount.text else { return true }
//        if string.isEmpty {
//            return true
//        } else {
//            return text.count < 3
//        }
//        guard let text = situpCount.text else { return true }
//        if string.isEmpty {
//            return true
//        } else {
//            return text.count < 3
//        }
    }
}

//
//  FitnessTestAddViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/12.
//

import UIKit
import Toast_Swift

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
//    private var diaryDate: Date?
    
    override func viewWillAppear(_ animated: Bool) {
        title = "체력검정기록 추가"
//        navigationController?.navigationBar.topItem?.backButtonTitle = "체력검정"
//        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatePicker()
        view.backgroundColor = CustomColor.bgGray
        runningSwitch.isOn = false
        situpSwitch.isOn = false
        pushupSwitch.isOn = false
        runningMinute.backgroundColor = .systemGray6
        runningSecond.backgroundColor = .systemGray6
        pushupCount.backgroundColor = .systemGray6
        situpCount.backgroundColor = .systemGray6
        dateTextField.backgroundColor = .white
        dateTextField.layer.cornerRadius = 12
        runningMinute.layer.cornerRadius = 12
        runningSecond.layer.cornerRadius = 12
        pushupCount.layer.cornerRadius = 12
        situpCount.layer.cornerRadius = 12
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = CustomColor.mainPurple
        
    }
    
    @objc func saveButtonClicked(){
        
        if dateTextField.text == "" {
            view.makeToast("날짜를 입력해주세요.", duration: 3.0, position: .bottom)
        }else {
            if exerciseAndTestSegment.selectedSegmentIndex == 0 {
                if (runningSwitch.isOn && (runningMinute.text == "" || runningSecond.text == "")) || (pushupSwitch.isOn && (pushupCount.text == "")) || (situpSwitch.isOn && situpCount.text == "") {
                    view.makeToast("빈칸없이 입력해주세요.", duration: 2.0, position: .bottom)
                }else {
                    if runningMinute.text != "" && runningSecond.text != "" {
                        RealmManager.saveFitnessTestData(date: datePicker.date, testType: "running", count: nil, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), level: calculateLevel(testType: .running, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), count: nil), isPractice: true)
                        view.makeToast("저장되었습니다.", duration: 2.0, position: .top)
                    }
                    if pushupCount.text != "" {
                        RealmManager.saveFitnessTestData(date: datePicker.date, testType: "pushup", count: Int(pushupCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .pushup, minutes: nil, seconds: nil, count: Int(pushupCount.text!)), isPractice: true)
                        view.makeToast("저장되었습니다.", duration: 2.0, position: .top)
                    }
                    if situpCount.text != "" {
                        RealmManager.saveFitnessTestData(date: datePicker.date, testType: "situp", count: Int(situpCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .situp, minutes: nil, seconds: nil, count: Int(situpCount.text!)), isPractice: true)
                        view.makeToast("저장되었습니다.", duration: 2.0, position: .top)
                    }
                }
            }else {
                if runningMinute.text == "" || runningSecond.text == "" || pushupCount.text == "" || situpCount.text == "" {
                    view.makeToast("빈칸없이 입력해주세요.", duration: 2.0, position: .bottom)
                }else {
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "running", count: nil, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), level: calculateLevel(testType: .running, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), count: nil), isPractice: false)
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "pushup", count: Int(pushupCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .pushup, minutes: nil, seconds: nil, count: Int(pushupCount.text!)), isPractice: false)
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "situp", count: Int(situpCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .situp, minutes: nil, seconds: nil, count: Int(situpCount.text!)), isPractice: false)
                    view.makeToast("저장되었습니다.", duration: 2.0, position: .top)
                }
            }
        }
        
//        if isValidNumber(intakeTextField.text) != 0{
//            if isValidNumber(intakeTextField.text) == 1{
//                let windows = UIApplication.shared.windows
//                windows.last?.makeToast(LocalizeStrings.empty_protein.localized)
////                self.view.makeToast(LocalizeStrings.empty_protein.localized)
//            }else {
//                let windows = UIApplication.shared.windows
//                windows.last?.makeToast(LocalizeStrings.error_number.localized)
////                self.view.makeToast(LocalizeStrings.error_number.localized)
//            }
    }
    @IBAction func runningSwitchClicked(_ sender: UISwitch) {
        runningMinute.isEnabled = runningSwitch.isOn
        runningSecond.isEnabled = runningSwitch.isOn
        if runningSwitch.isOn {
            runningMinute.backgroundColor = .white
            runningSecond.backgroundColor = .white
        }else {
            runningMinute.backgroundColor = .systemGray6
            runningSecond.backgroundColor = .systemGray6
            runningMinute.text = ""
            runningSecond.text = ""
        }
    }
    
    @IBAction func pushupSwitchClicked(_ sender: UISwitch) {
        pushupCount.isEnabled = pushupSwitch.isOn
        if pushupSwitch.isOn {
            pushupCount.backgroundColor = .white
        }else {
            pushupCount.backgroundColor = .systemGray6
            pushupCount.text = ""
        }
    }
    
    @IBAction func situpSwitchClicked(_ sender: UISwitch) {
        situpCount.isEnabled = situpSwitch.isOn
        if situpSwitch.isOn {
            situpCount.backgroundColor = .white
        }else {
            situpCount.backgroundColor = .systemGray6
            situpCount.text = ""
        }
    }
    
    @IBAction func changeSelction(_ sender: UISegmentedControl) {
        let selection = sender.selectedSegmentIndex
        switch selection {
        case 0:
            runningSwitch.isHidden = false
            pushupSwitch.isHidden = false
            situpSwitch.isHidden = false
            runningSwitch.isOn = false
            pushupSwitch.isOn = false
            situpSwitch.isOn = false
            runningSecond.text = ""
            runningMinute.text = ""
            pushupCount.text = ""
            situpCount.text = ""
            runningMinute.backgroundColor = .systemGray6
            runningSecond.backgroundColor = .systemGray6
            pushupCount.backgroundColor = .systemGray6
            situpCount.backgroundColor = .systemGray6

            
        case 1:
            runningSwitch.isHidden = true
            pushupSwitch.isHidden = true
            situpSwitch.isHidden = true
            runningMinute.isEnabled = true
            runningSecond.isEnabled = true
            pushupCount.isEnabled = true
            situpCount.isEnabled = true
            runningMinute.backgroundColor = .white
            runningSecond.backgroundColor = .white
            pushupCount.backgroundColor = .white
            situpCount.backgroundColor = .white
            runningSecond.text = ""
            runningMinute.text = ""
            pushupCount.text = ""
            situpCount.text = ""
        default: break
        }
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
        toolBar.setItems([flexible, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
//        self.diaryDate = datePicker.date
        self.datePicker.maximumDate = Date()
        self.dateTextField.text = formmater.string(from: datePicker.date)
    }
}

//extension FitnessTestAddViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = runningMinute.text else { return true }
//        if string.isEmpty {
//            return true
//        } else {
//            return text.count < 2
//        }
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
//    }
//}

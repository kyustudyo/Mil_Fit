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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var runningMinute: UITextField!
    @IBOutlet weak var runningSecond: UITextField!
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
//        runningSwitch.isOn = false
//        situpSwitch.isOn = false
//        pushupSwitch.isOn = false
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
            view.makeToast("날짜를 입력해주세요.", duration: 3.0, position: .top)
        }else {
            if exerciseAndTestSegment.selectedSegmentIndex == 0 {
                //빈칸이 몬가있을때
                
                
                
                
                if ((runningMinute.text == "" && runningSecond.text == "")) && ( pushupCount.text == "") && (situpCount.text == "") {
                    view.makeToast("기록을 입력해주세요.", duration: 2.0, position: .top)
                } else {
                    //빈칸이 없을때
                    
                    if runningMinute.text != "" {
                        guard (Int(runningMinute.text ?? "") != nil) else {
                            view.makeToast("숫자만 입력 가능합니다.", duration: 3.0, position: .top)
                            return
                        }
                    }
                    if runningSecond.text != "" {
                        guard (Int(runningSecond.text ?? "") != nil) else {
                            view.makeToast("숫자만 입력 가능합니다.", duration: 3.0, position: .top)
                            return
                            
                        }
                    }
                    if pushupCount.text != "" {
                        guard (Int(pushupCount.text ?? "") != nil) else {
                            view.makeToast("숫자만 입력 가능합니다.", duration: 3.0, position: .top)
                            return
                        }
                    }
                    if situpCount.text != "" {
                        guard (Int(situpCount.text ?? "") != nil) else {
                            view.makeToast("숫자만 입력 가능합니다.", duration: 3.0, position: .top)
                            return
                        }
                    }
                    
                    
                    if !(runningMinute.text == "" && runningSecond.text == "") {
                        
                        let min = (runningMinute.text == "") ? nil : runningMinute.text
                        let sec = (runningSecond.text == "") ? nil : runningSecond.text
                        
                        RealmManager.saveFitnessTestData(date: datePicker.date, testType: "running", count: nil, minutes: Int(min ?? "0"), seconds: Int(sec ?? "0"), level: calculateLevel(testType: .running, minutes: Int(min ?? "0"), seconds: Int(sec ?? "0"), count: nil), isPractice: true)
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
            }
            
            
            else {
                if runningMinute.text == "" || runningSecond.text == "" || pushupCount.text == "" || situpCount.text == "" {
                    view.makeToast("빈칸없이 입력해주세요.", duration: 2.0, position: .top)
                }else {
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "running", count: nil, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), level: calculateLevel(testType: .running, minutes: Int(runningMinute.text!), seconds: Int(runningSecond.text!), count: nil), isPractice: false)
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "pushup", count: Int(pushupCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .pushup, minutes: nil, seconds: nil, count: Int(pushupCount.text!)), isPractice: false)
                    RealmManager.saveFitnessTestData(date: datePicker.date, testType: "situp", count: Int(situpCount.text!), minutes: nil, seconds: nil, level: calculateLevel(testType: .situp, minutes: nil, seconds: nil, count: Int(situpCount.text!)), isPractice: false)
                    view.makeToast("저장되었습니다.", duration: 2.0, position: .top)
                }
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
    /*
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
*/


    
extension FitnessTestAddViewController: UITextFieldDelegate {
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
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func changeSelction(_ sender: UISegmentedControl) {
        runningSecond.text = ""
        runningMinute.text = ""
        pushupCount.text = ""
        situpCount.text = ""
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일"
        formmater.locale = Locale(identifier: "ko_KR")
        self.datePicker.maximumDate = Date()
        self.dateTextField.text = formmater.string(from: datePicker.date)
    }
    
}
    
extension FitnessTestAddViewController {
    func showToast(toastText: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 60, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        toastLabel.layer.borderColor = UIColor.systemGray5.cgColor
        toastLabel.layer.borderWidth = 1
        toastLabel.textColor = UIColor.black
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.text = toastText
        toastLabel.textAlignment = .center
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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

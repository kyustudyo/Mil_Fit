//
//  OnboardingLastViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import UIKit

class OnboardingLastViewController: UIViewController {
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var backButton: UINavigationItem!
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.bgGray
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationController?.navigationBar.topItem?.title = ""
        setDatePicker()
        textFieldDidEndEditing(dateTF)
        configToolbar()
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
    }
    
    //    @objc func dateChange(datePicker: UIDatePicker) {
    //        dateTF.text = formatData(date: datePicker.date)
    //    }
    //
    //    func formatData(date: Date) -> String {
    //        let formatter = DateFormatter()
    //        formatter.locale = Locale(identifier: "ko")
    //        formatter.dateFormat = "yyyy년 M월 dd일"
    //        return formatter.string(from: date)
    //    }
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter() // Date 타입과 관련된 포맷터
        formatter.dateFormat = "yyyy년 M월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        //            self.date = datePicker.date
        self.dateTF.text = formatter.string(from: datePicker.date)
    }
}

extension OnboardingLastViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: UIColor.systemGray5)
    }
}

extension OnboardingLastViewController: UIPickerViewDelegate {
    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        
        dateTF.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        self.dateTF.text = formatData(date: datePicker.date)
        self.dateTF.resignFirstResponder()
    }
    
    func formatData(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy년 M월 dd일"
        return formatter.string(from: date)
    }
    
    @objc func cancelPicker() {
        self.dateTF.text = nil
        self.dateTF.resignFirstResponder()
    }
}

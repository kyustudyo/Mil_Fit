//
//  DischargeDetailViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/17.
//

import UIKit

class DischargeDetailViewController: UIViewController {
    @IBOutlet weak var dischargeDateTextField: UITextField!
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColor.bgGray
        setDatePicker()
        configToolbar()
    }

    func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        
        dischargeDateTextField.inputView = datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter() // Date 타입과 관련된 포맷터
        formatter.dateFormat = "yyyy년 M월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        //            self.date = datePicker.date
        self.dischargeDateTextField.text = formatter.string(from: datePicker.date)
    }
}

extension DischargeDetailViewController: UIPickerViewDelegate {
    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        
        dischargeDateTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        self.dischargeDateTextField.text = formatData(date: datePicker.date)
        self.dischargeDateTextField.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        self.dischargeDateTextField.text = nil
        self.dischargeDateTextField.resignFirstResponder()
    }
    
    func formatData(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy년 M월 dd일"
        return formatter.string(from: date)
    }
}

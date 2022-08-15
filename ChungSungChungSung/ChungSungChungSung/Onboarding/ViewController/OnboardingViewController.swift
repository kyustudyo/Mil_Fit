//
//  OnboardingViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import Foundation
import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    private var age = ["19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32"]
    private let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.bgGray
        nextButton.tintColor = CustomColor.mainPurple
        configPickerView()
        configToolbar()
    }
}

// age picker 설정
extension OnboardingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        inputAge.inputView = picker
        
        configToolbar()
        textFieldDidEndEditing(inputAge)
    }
    
    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        
        inputAge.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.inputAge.text = self.age[row]
        self.inputAge.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        self.inputAge.text = nil
        self.inputAge.resignFirstResponder()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return age.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return age[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.inputAge.text = self.age[row]
    }
}

extension OnboardingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: UIColor.systemGray5)
    }
}

// textfield underline
extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 48, height: 1)
        border.borderWidth = 1
        self.layer.addSublayer(border)
    }
}


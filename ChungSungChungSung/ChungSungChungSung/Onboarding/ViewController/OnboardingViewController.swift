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
    private var age = ["19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32"]
    private let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.bgGray
        inputAge.setBottomBorder()
        configPickerView()
        configToolbar()
    }
}

extension UITextField {
    func setBottomBorder() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray3.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension OnboardingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        inputAge.inputView = picker
        
        configToolbar()
        textFieldDidBeginEditing(inputAge)
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: UIColor.systemOrange)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: UIColor.systemGray5)
    }
}

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}


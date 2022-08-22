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
    private let defaults = UserDefaults.standard
    
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction private func didTapNextButton(_ sender: UIBarButtonItem) {
        guard let onboardingSecondView = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingSecondViewController") as? OnboardingSecondViewController else { return }
        
        if inputAge.text?.isEmpty == true {
            showToast()
        } else {
            if let inputAge = inputAge.text {
                if let ageInt = Int(inputAge) {
                    UserDefaultManager.saveAge(age: ageInt)
                    print(ageInt)
                }
            }
            self.navigationController?.pushViewController(onboardingSecondView, animated: true)
        }
    }
    
//    private var age = ["19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32","33"]
    private var age = Range(19...60).map{String($0)}
    private let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.bgGray
        nextButton.tintColor = CustomColor.mainPurple
        configPickerView()
        configToolbar()
    }
    
    func isValidNumber(_ text: String?) -> Int {

        guard let text = text else {
            return ErrorString.EmptyString.rawValue
        }
        
        if text.isEmpty { return ErrorString.EmptyString.rawValue}
        if Int(text) == nil { return ErrorString.NotNumber.rawValue}
        else if Int(text) == 0 { return ErrorString.Zero.rawValue}
        return 0
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
    
    func showToast() {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 60, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        toastLabel.layer.borderColor = UIColor.systemGray5.cgColor
        toastLabel.layer.borderWidth = 1
        toastLabel.textColor = UIColor.black
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.text = "나이를 입력해주세요."
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


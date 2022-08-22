//
//  OnboardingLastViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import UIKit

class OnboardingLastViewController: UIViewController {
    private let defaults = UserDefaults.standard
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var backButton: UINavigationItem!
    private let datePicker = UIDatePicker()
    
    @IBAction private func didTapDoneButton(_ sender: UIBarButtonItem) {
        
        if dateTF.text?.isEmpty == true {
            showToast()
        } else {
            if let dateString = dateTF.text {
                let date = formatStringToDate(dateString: dateString)
                
                if let date = date {
                    UserDefaultManager.saveDischargeDate(date: date.addingTimeInterval(60*60*9))
                    UserDefaultManager.saveStartDate(date: Date())
                    let vc = TabViewController()
                    
                    RealmManager.saveBadgeData(date: Date().addingTimeInterval(60*60*9), title: "우리의 시작")
                    RealmManager.saveBadgeData(date: Date().addingTimeInterval(60*60*9), title: "첫 기록의 기쁨")
                    
                    self.navigationController?.isNavigationBarHidden = true
                    self.navigationController?.pushViewController(vc, animated: true)
//                    vc.modalPresentationStyle = .fullScreen
//                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.bgGray
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
//        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter() // Date 타입과 관련된 포맷터
        formatter.dateFormat = "yyyy년 M월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        //            self.date = datePicker.date
        self.dateTF.text = formatter.string(from: datePicker.date)
    }
    
    func showToast() {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 60, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        toastLabel.layer.borderColor = UIColor.systemGray5.cgColor
        toastLabel.layer.borderWidth = 1
        toastLabel.textColor = UIColor.black
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.text = "전역일을 입력해주세요."
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
    
    func formatStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        let convertStr = dateFormatter.date(from: dateString)
        
        if let date = convertStr {
            return date
        } else {
            return nil
        }
    }
    
    @objc func cancelPicker() {
        self.dateTF.text = nil
        self.dateTF.resignFirstResponder()
    }
}

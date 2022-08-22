//
//  OnboardingSecondViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import UIKit
import RealmSwift

class OnboardingSecondViewController: UIViewController {
    private let defaults = UserDefaults.standard
    
    private var weightRealm: Results<WeightRealm>!
    private var date = Date()
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction private func didTapNextButton(_ sender: UIBarButtonItem) {
        guard let onboardingLastView = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingLastViewController") as? OnboardingLastViewController else { return }
        
        let heightText = heightTextField.text
        let weightText = weightTextField.text
        
        if let heightText = heightText {
            if let weightText = weightText {
                
                if heightText.isEmpty == true || weightText.isEmpty == true {
                    showToast(toastText: "키와 체중을 입력해주세요.")
                    
                } else if Int(heightText) == nil || Int(weightText) == nil {
                    showToast(toastText: "숫자를 입력해주세요.")
                } else if Int(heightText) == 0 || Int(weightText) == 0 {
                    showToast(toastText: "키와 체중을 입력해주세요.")
                } else {
                    if let heightInt = Int(heightText) {
                        UserDefaultManager.saveHeight(height: heightInt)
                        print("키 \(heightInt)")
                    }
                    if let weightInt = Int(weightText) {
                        RealmManager.saveWeightData(date: date, weight: weightInt)
                        print("몸무게 \(weightInt)")
                    }
                    

                    let a = 13.8 * Double(Int(weightText) ?? 0)
                    let b = 5 * Double(Int(heightText) ?? 0)
                    let c = 6.8 * Double(UserDefaultManager.loadAge() ?? 0)
                    let cal = 66 + a + b - c
                    
                    UserDefaultManager.saveBMR(BMR: Int(cal))
                    
                    self.navigationController?.pushViewController(onboardingLastView, animated: true)
                }
                            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColor.bgGray
        textFieldDidEndEditing(heightTextField)
        textFieldDidEndEditing(weightTextField)
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationController?.navigationBar.topItem?.title = ""
        nextButton.tintColor = CustomColor.mainPurple
    }
    
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

extension OnboardingSecondViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width / 2, color: UIColor.systemGray5)
    }
}

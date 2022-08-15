//
//  OnboardingSecondViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import UIKit

class OnboardingSecondViewController: UIViewController {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColor.bgGray
        textFieldDidEndEditing(heightTextField)
        textFieldDidEndEditing(weightTextField)
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationController?.navigationBar.topItem?.title = ""
        nextButton.tintColor = CustomColor.mainPurple
    }
}

extension OnboardingSecondViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width / 2, color: UIColor.systemGray5)
    }
}

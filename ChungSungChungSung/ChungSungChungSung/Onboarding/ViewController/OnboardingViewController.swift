//
//  OnboardingViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/15.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var inputAge: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

class UnderlineTextField: UITextField {
    lazy var placeholderColor: UIColor = self.tintColor
    lazy var placehoderString: String = ""
    
    private lazy var underLineView: UIView = {
       let lineView = UIView()
        lineView.backgroundColor = .blue
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(underLineView)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
    self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
}

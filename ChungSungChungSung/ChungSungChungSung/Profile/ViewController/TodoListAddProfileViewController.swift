//
//  TodoListAddProfileViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/13.
//

import UIKit

class TodoListAddProfileViewController: UIViewController {

    @IBOutlet weak var todoContentTextField: UITextField!
    @IBOutlet weak var todoListLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawUI()
    }
    
    private func drawUI() {
        todoListLabel.text = "달성하고 싶은\n목표를 적어보세요."
        todoContentTextField.layer.cornerRadius = 12
    }
}

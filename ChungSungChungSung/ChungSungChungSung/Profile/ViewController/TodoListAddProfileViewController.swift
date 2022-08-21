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
    weak var delegate: TodoAdd?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let plusButton = UIButton()
        
//        let plusImage = UIImage(systemName: "plus")
//        plusButton.setImage(plusImage, for: .normal)
//        plusButton.addTarget(self, action: #selector(goAddGoalViewController), for: .touchUpInside)
        let plusButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(completeAdd))

//        let plusBarButton = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItems = [plusButton]
        
        self.view.backgroundColor = CustomColor.bgGray
        drawUI()
    }
    @objc private func completeAdd() {
        if let tf = todoContentTextField.text,
           !tf.isEmpty {
            RealmManager.saveTodoListData(date: Date(), content: tf, isDone: false)
            if let notDoneTodos = RealmManager.notDoneTodoData2() {
//                goalList = notDoneTodos
                print(notDoneTodos.count)
            }
            
            delegate?.addTodo()
            navigationController?.popViewController(animated: true)
        }
        
    }
    private func drawUI() {
        todoListLabel.text = "달성하고 싶은\n목표를 적어보세요."
        todoListLabel.numberOfLines = 2
        todoContentTextField.layer.cornerRadius = 12
    }
}

extension TodoListAddProfileViewController: UITextFieldDelegate {
    
    
}
protocol TodoAdd: AnyObject {
    func addTodo()
}

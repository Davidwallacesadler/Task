//
//  TaskTableViewCell.swift
//  Task
//
//  Created by David Sadler on 4/29/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let selectedDelegate = delegate else { return }
        selectedDelegate.buttonCellButtonTapped(self)
    }
    
    // MARK: - Delegate Property
    
    // So we use a protocol as a delegate here becasue we dont want any logic code within out ButtonTableViewCell class definition?
    
    var delegate: ButtonTableViewCellDelegate?
    
    // MARK: - Internal Methods
    
    func updateButton(_ isComplete: Bool) {
        if isComplete == true {
            completeButton.setImage(UIImage(named: "buttonChecked"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "buttonNotChecked"), for: .normal)
        }
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = "'\(task.name ?? "")' due:'\(task.due?.stringValue() ?? "")'"
        updateButton(task.isComplete)
    }
}


protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

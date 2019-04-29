//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by David Sadler on 4/29/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Internal Properties
    
    var task: Task? {
        didSet {
            // added a property observer so that when we pass a task from the taskListVC the update views function is called to reflect the desired task properties.
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    // MARK: - Outlets
    
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let selectedTask = task, let taskName = nameTextField.text, let taskNotes = notesTextView.text, let taskDueOn = dueDateValue else {
            TaskController.shared.add(taskWithName: nameTextField.text ?? "Task", notes: notesTextView.text, due: dueDateValue ?? nil)
            self.navigationController?.popViewController(animated: true)
            return
        }
        TaskController.shared.update(task: selectedTask, name: taskName, notes: taskNotes, due: taskDueOn)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateTextField.text = sender.date.stringValue()
        dueDateValue = sender.date
    }
    
    // THIS IS NOT GETTING CALLED?
    // JUST USED METHOD IN VIEW DID LOAD -- SEE WHAT I DID WRONG HERE -- ITS NOT GETTING CALLED ANYWHERE SO THATS PROBABLY THE PROBLEM
//    @IBAction func userTappedView(_ sender: Any) {
//        self.nameTextField.resignFirstResponder()
//        self.dueDateTextField.resignFirstResponder()
//        self.nameTextField.resignFirstResponder()
//    }
    
    
    // MARK: - Internal Methods
    
    
    
    private func updateViews() {
        guard let selectedTask = task, isViewLoaded else { return }
        nameTextField.text = selectedTask.name
        dueDateTextField.text = selectedTask.due?.stringValue()
        notesTextView.text = selectedTask.notes
        self.navigationItem.title = selectedTask.name
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

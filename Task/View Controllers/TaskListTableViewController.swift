//
//  TaskListTableViewController.swift
//  Task
//
//  Created by David Sadler on 4/29/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    // MARK: - Delegate Methods
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let selectedTask = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: selectedTask)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    // MARK: - TableView Data Source Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {
            print("The selected cell is not an instance of buttonTableViewCell")
            return UITableViewCell()
        }
        let task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self
        cell.update(withTask: task)
        return cell
    }
    
    // MARK: - TableView Editing

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedTaskIndex = indexPath.row
            let task = TaskController.shared.tasks[selectedTaskIndex]
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowTask" {
            guard let taskDetailVC = segue.destination as? TaskDetailTableViewController,
                let index = tableView.indexPathForSelectedRow?.row else { return }
                let selectedTask = TaskController.shared.tasks[index]
                taskDetailVC.task = selectedTask
                taskDetailVC.dueDateValue = selectedTask.due
        }
    }

}

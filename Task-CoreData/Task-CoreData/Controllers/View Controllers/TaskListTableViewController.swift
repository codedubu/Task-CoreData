//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/19/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TaskController.shared.fetchTasks()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.sections[indexPath.section][indexPath.row]
        
        cell.delegate = self
        cell.task = task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Incomplete"
        } else {
            return "Completed"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.sections[indexPath.section][indexPath.row]
            TaskController.shared.deleteTask(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            
            let taskToSend = TaskController.shared.sections[indexPath.section][indexPath.row]
            destination.task = taskToSend
        }
    }
} // End of class

extension TaskListTableViewController: TaskCompletionDelegate {
    
    func taskCellButtonTapped(_ sender: TaskTableViewCell, isComplete: Bool, task: Task) {
        
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsComplete(task: task)
        TaskController.shared.updateTaskCompletionStatus(task: task)
        
        sender.updateViews()
        tableView.reloadData()
    }
} // End of extension

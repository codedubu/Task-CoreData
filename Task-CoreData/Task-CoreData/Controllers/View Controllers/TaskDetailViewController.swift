//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/19/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotesTextView.text, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: taskName, notes: taskNotesTextView.text, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let sentTask = task else { return }
        taskNameTextField.text = sentTask.name
        taskNotesTextView.text = sentTask.notes
        taskDueDatePicker.date = sentTask.dueDate ?? Date()
    }
    
}

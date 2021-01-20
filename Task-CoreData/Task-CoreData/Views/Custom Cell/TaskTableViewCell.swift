//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/19/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var taskDueDateLabel: UILabel!
    
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.taskCellButtonTapped(self)
        }
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        
        let image = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        
        completionButton.setImage(image, for: .normal)
        
        guard let date = task.dueDate else { return }
        taskDueDateLabel.text = date.dateToString()
    }
    
    
} // End of class


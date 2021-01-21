//
//  TaskController.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/19/21.
//

import CoreData

class TaskController {
    
    // MARK: - Shared Instance
    static let shared = TaskController()
    let notificationScheduler = NotificationScheduler()
    
    // MARK: - Source of Truth
    var sections: [[Task]] { [notCompletedTasks, completedTasks] }
    
    
    var notCompletedTasks: [Task] = []
    var completedTasks: [Task] = []
    //    var tasks: [Task] = []
    
    // MARK: - Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
        
    }()
    
    
    // MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        notCompletedTasks.append(newTask)
        notificationScheduler.scheduleNotifications(task: newTask)
        CoreDataStack.saveContext()
        
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        completedTasks = tasks.filter { $0.isComplete == true }
        notCompletedTasks = tasks.filter { $0.isComplete == false }
        
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        notificationScheduler.cancelNotifications(task: task)
        notificationScheduler.scheduleNotifications(task: task)
        CoreDataStack.saveContext()
    }
    
    func updateTaskCompletionStatus(task: Task){
        if task.isComplete {
            //could be something here
            if let index = notCompletedTasks.firstIndex(of: task) {
                notCompletedTasks.remove(at: index)
                completedTasks.append(task)
            }
        } else {
            if let index = completedTasks.firstIndex(of: task) {
                completedTasks.remove(at: index)
                notCompletedTasks.append(task)
            }
        }
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }

    func deleteTask(task: Task) {
        if task.isComplete {
            if let index = completedTasks.firstIndex(of: task) {
                completedTasks.remove(at: index)
            }
        } else {
            if let index = notCompletedTasks.firstIndex(of: task) {
                notCompletedTasks.remove(at: index)
            }
        }
        CoreDataStack.container.viewContext.delete(task)
        notificationScheduler.cancelNotifications(task: task)
        CoreDataStack.saveContext()
        
    }
    
} // End of class

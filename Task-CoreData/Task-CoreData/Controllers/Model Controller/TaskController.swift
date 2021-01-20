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
    
    // MARK: - Source of Truth
    var tasks: [Task] = []
    
    // MARK: - Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
        
    }()
    
    
    // MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
        
    }
    
    func fetchTasks() {
        self.tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        CoreDataStack.saveContext()
    }
    
    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            CoreDataStack.container.viewContext.delete(task)
        }
        CoreDataStack.saveContext()
    }
    
} // End of class

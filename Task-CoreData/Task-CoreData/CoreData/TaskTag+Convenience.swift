//
//  TaskTag+Convenience.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/20/21.
//

import CoreData
    
extension TaskTag {
    @discardableResult convenience
    init(name: String, task: Task, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.task = task
        
    }
    
}

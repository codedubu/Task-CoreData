//
//  TaskCompletion+Convenience.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/19/21.
//

import CoreData

extension TaskCompletion {
    
    @discardableResult convenience init(completionStatus: Bool, task: Task, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context:context)
        self.completionStatus = completionStatus
        self.task = task
        
    }
    
}

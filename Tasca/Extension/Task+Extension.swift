//
//  Task+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 18/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData


extension Task{
    static func fetchQuery(viewContext: NSManagedObjectContext, selectedMilestone: String, predicate: NSPredicate? = nil, selectedProject: String) -> [Task]{
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let milestonepredicate = NSPredicate(format: "milestoneOf.milestoneId MATCHES %@ && milestoneOf.projectOf.projectId MATCHES %@", selectedMilestone, selectedProject)
        
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [milestonepredicate, addtionalPredicate])
        } else {
            request.predicate = milestonepredicate
        }
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
        
    }
    
    static func fetchTask(viewContext: NSManagedObjectContext, selectedMilestone: String, predicate: NSPredicate? = nil) -> [Task]{
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let taskpredicate = NSPredicate(format: "milestoneOf.milestoneId MATCHES %@", selectedMilestone)
        
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [taskpredicate, addtionalPredicate])
        } else {
            request.predicate = taskpredicate
        }
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
        
    }
    
    
    static func save(viewContext: NSManagedObjectContext, taskName: String, selectedMilestone: Milestone, isChecklist: Bool) -> Task? {
        let newTask = Task(context: viewContext)
        newTask.taskId = UUID().uuidString
        newTask.taskName = taskName
        newTask.isChecklist = isChecklist
        newTask.milestoneOf = selectedMilestone
        
        do {
          try viewContext.save()
            return newTask
        } catch {
           return nil
        }
    }
    
    static func update(viewContext: NSManagedObjectContext, taskName: String, task:[Task], indexTask: Int, isChecklist: Bool){
        
        task[indexTask].taskName = taskName
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    static func isCompleted(viewContext: NSManagedObjectContext, isCompleted: Bool, task:[Task], indexTask: Int){
        task[indexTask].isChecklist = isCompleted
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
}

//
//  Project+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData

extension Project{
//    static func fetchQuery(viewCopntext: NSManagedObjectContext) -> [Project]{
//        let request: NSFetchRequest<Project> = Project.fetchRequest()
//        
//        let predicate = NSPredicate(format: "taskName BEGINSWITH @%", [])
//        request.predicate = predicate
//        let result = try? viewCopntext.fetch(request)
//        return result ?? []
//        
//    }
    
//    static func fetchAll(viewContext: NSManagedObjectContext) -> [Project] {
//        
//        let request: NSFetchRequest<Project> = Project.fetchRequest()
//        
//        guard let result = try? viewContext.fetch(request) else{
//            return []
//        }
//        return result
//    }
    
    static func fetchCompleted(viewContext: NSManagedObjectContext) -> [Project] {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        let predicate = NSPredicate(format: "isCompleted = \(NSNumber(value: true))")
        request.predicate = predicate
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
    }
    
    static func fetchNotCompleted(viewContext: NSManagedObjectContext) -> [Project] {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        let predicate = NSPredicate(format: "isCompleted = \(NSNumber(value: false))")
        request.predicate = predicate
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
    }
    
    static func fetchProject(viewContext: NSManagedObjectContext, selectedMilestone: String, predicate: NSPredicate? = nil) -> [Project]{
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        
        let projectpredicate = NSPredicate(format: "ANY milestone.milestoneId = %@", selectedMilestone)
        
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [projectpredicate, addtionalPredicate])
        } else {
            request.predicate = projectpredicate
        }
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
        
    }
 
    
    static func save(viewContext: NSManagedObjectContext, projectName: String, clientName: String, deadline: Date, color: String, isCompleted: Bool, projectCompletionReward: String) -> Project? {
        let project = Project(context: viewContext)
        project.projectId = UUID().uuidString
        project.projectName = projectName
        project.clientName = clientName
        project.deadline = deadline
        project.color = color
        project.projectCompletionReward = projectCompletionReward
        project.isCompleted = isCompleted
        
        
        
        do {
            try viewContext.save()
            Notifications.setNotification(project: project)
            return project
        } catch  {
            return nil
        }
        
    }
    
    static func update(viewContext: NSManagedObjectContext, projectName: String, clientName: String, deadline: Date, color: String, isCompleted: Bool, projectCompletionReward: String, project:[Project], indexProject: Int){
        
        project[indexProject].projectName = projectName
        project[indexProject].clientName = clientName
        project[indexProject].deadline = deadline
        project[indexProject].color = color
        project[indexProject].isCompleted = isCompleted
        project[indexProject].projectCompletionReward = projectCompletionReward
        
        Notifications.setNotification(project: project[indexProject])
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    static func isCompleted(viewContext: NSManagedObjectContext, isCompleted: Bool, project:[Project], indexProject: Int){
        project[indexProject].isCompleted = isCompleted
        
        Notifications.removeNotification(project[indexProject])
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext){

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? viewContext.execute(deleteRequest)
        
    }
    
    static func deleteData(viewContext: NSManagedObjectContext, project: [Project], indexProject: Int){
        viewContext.delete(project[indexProject])
        
        Notifications.removeNotification(project[indexProject])
        
        do {
            try viewContext.save()
        } catch {
           
        }
    }
}

//
//  TaskController.swift
//  Task
//
//  Created by David Sadler on 4/29/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // MARK: - Shared instance
    
    static let shared = TaskController()
    
    // MARK: - Initializer
    
    init() {
        tasks = fetchTasks()
    }
    
    
    // MARK: - Internal Properties
    
    var tasks: [Task] = []
    
    
    // MARK: - CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func toggleIsCompleteFor(task: Task) {
        if task.isComplete == true {
            task.isComplete = false
        } else {
            task.isComplete = true
        }
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving Managed Object Context. Items not saved: \(error)")
        }
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
}

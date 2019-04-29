//
//  TaskController.swift
//  Task
//
//  Created by David Sadler on 4/29/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import Foundation

class TaskController {
    
    // MARK: - Shared instance
    
    static let shared = TaskController()
    
    // MARK: - Initializer
    
    init() {
        tasks = fetchTasks()
    }
    
    
    // MARK: - Internal Properties
    
    var tasks: [Task] = []
    
    // MARK: - Mock Data
    
    var taskData: [Task] {
        get {
            let now = Date.init()
            let later = Date.distantFuture
            let task1 = Task(name: "Eat", notes: "I need to eat food", due: now)
            task1.isComplete = true
            let task2 = Task(name: "Shit", notes: "I need to shit at some point", due: later)
            let mockTasks : [Task] = [task1, task2]
            return mockTasks
        }
    }
    
    
    // MARK: - CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    func remove(task: Task) {
        
    }
    
    func saveToPersistentStore() {
        
    }
    
    func fetchTasks() -> [Task] {
        return taskData
    }
    
}

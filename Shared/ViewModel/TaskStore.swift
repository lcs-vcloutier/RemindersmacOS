//
//  TaskStore.swift
//  Reminders (iOS)
//
//  Created by Vincent Cloutier on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    
    // MARK: Stored propeties
    @Published var tasks: [Task]
    
    // MARK: Initializers
    init(tasks: [Task] = []) {
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        do {
            let data = try Data(contentsOf: filename)
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print(error.localizedDescription)
            self.tasks = tasks
        }
    }
    
    // MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    func moveItems(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    func saveTask(description: String, priority: TaskPriority) {
        tasks.append(Task(description: description, priority: priority, completed: false))
    }
    func persistTasks() {
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self.tasks)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    func delete(_ taskToDelete: Task) {
        tasks.removeAll(where: { currentTask in
            currentTask.id == taskToDelete.id
        })
    }
}

let testStore = TaskStore(tasks: testData)

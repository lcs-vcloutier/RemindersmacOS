//
//  EditTask.swift
//  Reminders (iOS)
//
//  Created by Vincent Cloutier on 2022-01-25.
//

import SwiftUI

struct EditTask: View {
    @ObservedObject var store: TaskStore
    @ObservedObject var task: Task
    @State private var description = ""
    @State private var priority = TaskPriority.low
    @Binding var showing: Bool
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    Picker("Priority", selection: $priority) {
                        Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                        Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                        Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        store.delete(task)
                        store.saveTask(description: description, priority: priority)
                        showing = false
                    }
                    .disabled(description.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showing = false
                    }
                }
            }
        }
        .interactiveDismissDisabled()
        .task {
            description = task.description
            priority = task.priority
        }
    }
}

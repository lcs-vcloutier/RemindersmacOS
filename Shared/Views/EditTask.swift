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
    let title = "Edit Reminder"
    var body: some View {
        VStack(alignment: .leading) {
            
#if os(macOS)
            Text(title)
                .font(.title2)
                .bold()
#endif
            Form {
                TextField("Description", text: $description)
                Picker("Priority", selection: $priority) {
                    Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                    Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                    Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
#if os(macOS)
            Spacer()
#endif
        }
#if os(macOS)
        .padding()
#endif
        
        .navigationTitle("New Reminder")
        .toolbar {
            ToolbarItem(placement: .automatic) {
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
        .interactiveDismissDisabled()
        .task {
            description = task.description
            priority = task.priority
        }
    }
}

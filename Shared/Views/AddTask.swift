//
//  AddTask.swift
//  Reminders
//
//  Created by Vincent Cloutier on 2022-01-20.
//

import SwiftUI

struct AddTask: View {
    @ObservedObject var store: TaskStore
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
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
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
    }
}

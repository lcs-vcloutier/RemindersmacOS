//
//  ImportantTaskView.swift
//  Reminders (iOS)
//
//  Created by Vincent Cloutier on 2022-01-25.
//

import SwiftUI

struct ImportantTaskView: View {
    @ObservedObject var store: TaskStore
    @State private var showingAddTask = false
    @State private var showingEditTask = false
    @State private var selectedTask = Task(description: "", priority: .low, completed: false)
    @State var showingCompletedTasks = true
    @State var listShouldUpdate = false
    var body: some View {
        List {
            ForEach(store.tasks) { task in
                if showingCompletedTasks {
                    if task.priority == .high {
                        TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                    }
                } else {
                    if !task.completed {
                        if task.priority == .high {
                            TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                        }
                    }
                }
            }
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItems)
        }
        .navigationTitle("Important")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingCompletedTasks.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.circle")
                }
            }
#if os(iOS)
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
#endif
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
        }
    }
}

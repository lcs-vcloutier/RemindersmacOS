//
//  ContentView.swift
//  Shared
//
//  Created by Vincent Cloutier on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: TaskStore
    @State private var showingAddTask = false
    @State private var showingEditTask = false
    @State private var selectedTask = Task(description: "", priority: .low, completed: false)
    @State var showingCompletedTasks = true
    @State var listShouldUpdate = false
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    var body: some View {
        let _ = print("\(listShouldUpdate)")
        List {
            ForEach(store.tasks) { task in
                if showingCompletedTasks {
                    if selectedPriorityForVisibleTasks == .all {
                        TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                            .deleteMenuItem(store: store, task: task)
                    } else {
                        if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                            TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                                .deleteMenuItem(store: store, task: task)
                        }
                    }
                } else {
                    if !task.completed {
                        if selectedPriorityForVisibleTasks == .all {
                            TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                                .deleteMenuItem(store: store, task: task)
                        } else {
                            if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                                TaskCell(task: task, selectedTask: $selectedTask, showingEditTask: $showingEditTask, triggerListUpdate: .constant(true))
                                    .deleteMenuItem(store: store, task: task)
                            }
                        }
                    }
                }
            }
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItems)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem {
                Button {
                    showingAddTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button(showingCompletedTasks ? "Hide completed tasks" : "Show completed tasks") {
                        showingCompletedTasks.toggle()
                    }
                    Picker("Filter tasks by priority", selection: $selectedPriorityForVisibleTasks) {
                        Text(VisibleTaskPriority.all.rawValue).tag(VisibleTaskPriority.all)
                        Text(VisibleTaskPriority.low.rawValue).tag(VisibleTaskPriority.low)
                        Text(VisibleTaskPriority.medium.rawValue).tag(VisibleTaskPriority.medium)
                        Text(VisibleTaskPriority.high.rawValue).tag(VisibleTaskPriority.high)
                    }
                    .pickerStyle(MenuPickerStyle())
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
#if os(iOS)
            NavigationView {
                AddTask(store: store, showing: $showingAddTask)
            }
#else
            AddTask(store: store, showing: $showingAddTask)
#endif
        }
        .sheet(isPresented: $showingEditTask) {
            EditTask(store: store, task: selectedTask, showing: $showingEditTask)
        }
    }
}

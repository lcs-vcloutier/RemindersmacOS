//
//  TaskCell.swift
//  Reminders
//
//  Created by Vincent Cloutier on 2022-01-20.
//

import SwiftUI

struct TaskCell: View {
    @ObservedObject var task: Task
    @Binding var selectedTask: Task
    @Binding var showingEditTask: Bool
    var taskColor: Color {
        switch task.priority {
        case .high:
            return Color.red
        case .medium:
            return Color.blue
        case .low:
            return Color.primary
        }
    }
    @Binding var triggerListUpdate: Bool
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    task.completed.toggle()
                    withAnimation {
                        triggerListUpdate.toggle()
                    }
                }
            Text(task.description)
        }
        .foregroundColor(self.taskColor)
        .onTapGesture(count: 2) {
            selectedTask = task
            showingEditTask = true
        }
    }
}

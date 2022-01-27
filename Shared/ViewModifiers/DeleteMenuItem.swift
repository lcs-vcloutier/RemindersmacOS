//
//  DeleteMenuItem.swift
//  RemindersFinal
//
//  Created by Vincent Cloutier on 2022-01-27.
//

import Foundation
import SwiftUI

struct DeleteMenuItem: ViewModifier {
    let store: TaskStore
    let task: Task
    func body(content: Content) -> some View {
        content
        .contextMenu {
            
            Button(action: {
                withAnimation {
                    store.delete(task)
                }
            }) {
                #if os(macOS)
                Text("\(Image(systemName: "trash.fill"))\tDelete")
                    .foregroundColor(.red)
                #else
                Label("Delete", systemImage: "trash.fill")
                #endif
            }
        }
    }
}

// Custom view modifier for the above thing
extension View {
    func deleteMenuItem(store: TaskStore, task: Task) -> some View {
        modifier(DeleteMenuItem(store: store, task: task))
    }
}

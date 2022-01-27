//
//  RemindersFinalApp.swift
//  Shared
//
//  Created by Vincent Cloutier on 2022-01-27.
//

import SwiftUI

@main
struct RemindersApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var store = TaskStore(tasks: testData)
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {ContentView(store: store)}
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle.fill")
                }
                NavigationView {ImportantTaskView(store: store)}
                .tabItem {
                    Label("Important", systemImage: "exclamationmark.circle.fill")
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Backgrounded")
                store.persistTasks()
            }
        }
    }
}

//
//  Task_ManagerApp.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/10/22.
//

import SwiftUI

@main
struct Task_ManagerApp: App {
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @State private var addingTask = false
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @State private var addingList = false
    /// Local storage for tasks
    @StateObject private var store = TaskStore()
    
    
    var body: some Scene {
        WindowGroup {
            if addingList {
                AddListView(addingTask: $addingTask, addingList: $addingList)
                    .background(Color(white: 0.925))
            } else if addingTask {
                AddTaskView(addingTask: $addingTask, addingList: $addingList)
                    .background(Color(white: 0.925))
            } else {
                DashboardView($addingTask, $addingList, $store.tasks) {
                    TaskStore.save(tasks: store.tasks) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                    .background(Color(white: 0.925))
                    .onAppear { // Load data on app launch
                        TaskStore.load { result in
                            switch result {
                            case .failure(let error):
                                fatalError(error.localizedDescription)
                            case .success(let tasks):
                                store.tasks = tasks
                            }
                        }
                    }
            }
        }
    }
}

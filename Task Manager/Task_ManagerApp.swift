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
    
    var body: some Scene {
        WindowGroup {
            if addingList {
                AddListView(addingTask: $addingTask, addingList: $addingList)
            } else if addingTask {
                AddListView(addingTask: $addingTask, addingList: $addingList)
            } else {
                ContentView(addingTask: $addingTask, addingList: $addingList)
            }
        }
    }
}

//
//  ContentView.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/10/22.
//

import SwiftUI

struct DashboardView: View {
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingTask: Bool
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingList: Bool
    @StateObject private var store = TaskStore()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                TitleView("Dashboard", systemImageName: "list.bullet.rectangle.fill", addingTask: $addingTask, addingList: $addingList)
                Spacer()
                Menu {
                    Button("Add Task", action: {
                        addingTask = true
                    })
                    Button("Add List", action: {
                        addingList = true
                    })
                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .padding(.trailing, 24)
            }
            .padding(.top, 16)
            VStack(alignment: .leading, spacing: 16) {
                if store.hasTasks(for: .today) {
                    /// A list dispaying only tasks with the specified  completion timeline
                    ///
                    /// This list displays tasks to be completed "today." The "today" list is unique
                    /// in that completed tasks are not filtered out. This provides a satisfying
                    /// visual of all that the user accomplished in the day.
                    TimeBasedTaskList(.today, tasks: $store.tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
                if store.hasTasks(for: .endOfWeek) {
                    TimeBasedTaskList(.endOfWeek, tasks: $store.tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
                if store.hasTasks(for: .endOfMonth) {
                    TimeBasedTaskList(.endOfMonth, tasks: $store.tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
            }
            Spacer()
        }
        .foregroundColor(Color(white:0.15))
        .padding(.leading, 24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(addingTask: .constant(false), addingList: .constant(false))
    }
}

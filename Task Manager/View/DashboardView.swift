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
    @Binding private var tasks: [Task]
    /// Used to monitor for inactive state
    @Environment(\.scenePhase) private var scenePhase
    /// An action to save task data, to be executed when entering the inactive state.
    let saveAction: () -> Void
    
    init(_ addingTask: Binding<Bool>,_ addingList: Binding<Bool>,_ tasks: Binding<[Task]>,_ completion: @escaping () -> Void) {
        self._addingList = addingList
        self._addingTask = addingTask
        self._tasks = tasks
        self.saveAction = completion
    }
    
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
                if tasksExist(withTimeframe: .today) {
                    /// A list dispaying only tasks with the specified  completion timeline
                    ///
                    /// This list displays tasks to be completed "today." The "today" list is unique
                    /// in that completed tasks are not filtered out. This provides a satisfying
                    /// visual of all that the user accomplished in the day.
                    TimeBasedTaskList(.today, tasks: $tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
                if tasksExist(withTimeframe: .endOfWeek) {
                    TimeBasedTaskList(.endOfWeek, tasks: $tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
                if tasksExist(withTimeframe: .endOfMonth) {
                    TimeBasedTaskList(.endOfMonth, tasks: $tasks)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                }
            }
            Spacer()
        }
        .foregroundColor(Color(white:0.15))
        .padding(.leading, 24)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    private func tasksExist(withTimeframe tf: timeframe) -> Bool {
        for tsk in tasks {
            if tsk.timeframe == tf {
                return true
            }
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("um")
    }
}

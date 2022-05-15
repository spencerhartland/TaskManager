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
    /// An SF Symbol: a plus sign within a filled square.
    private let addSymbol = Image(systemName: "plus.square.fill")
    
    var body: some View {
        VStack {
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
                    addSymbol
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .padding(.trailing, 24)
            }
            .padding(.top, 16)
            
            TimeBasedTaskList(.today)
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
            Spacer()
        }
        .foregroundColor(Color(white:0.15))
        .background(Color(white: 0.925))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(addingTask: .constant(false), addingList: .constant(false))
    }
}

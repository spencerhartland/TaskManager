//
//  ContentView.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/10/22.
//

import SwiftUI

struct ContentView: View {
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingTask: Bool
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingList: Bool
    
    var body: some View {
        VStack {
            TitleView("Dashboard", systemImageName: "list.bullet.rectangle.fill", addingTask: $addingTask, addingList: $addingList)
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
        ContentView(addingTask: .constant(false), addingList: .constant(false))
    }
}

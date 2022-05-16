//
//  AddTaskView.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/12/22.
//

import SwiftUI

struct AddTaskView: View {
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingTask: Bool
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingList: Bool
    @State var taskName: String = ""
    
    var body: some View {
        VStack {
            SecondaryTitleView("Add Task", addingTask: $addingTask, addingList: $addingList)
                .foregroundColor(Color(white:0.15))
            SimpleTextField("TASK", prompt: "What do you have to do?", userText: $taskName)
                .padding(.top, 32)
            Spacer()
            Text(taskName)
        }
        .padding([.top, .bottom], 48)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(addingTask: .constant(true), addingList: .constant(false))
    }
}

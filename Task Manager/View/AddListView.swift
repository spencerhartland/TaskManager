//
//  AddListView.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/12/22.
//

import SwiftUI

struct AddListView: View {
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
            SecondaryTitleView("Add List", addingTask: $addingTask, addingList: $addingList)
                .foregroundColor(Color(white:0.15))
            SimpleTextField("LIST", prompt: "What would you like to call this list?")
                .padding(.top, 32)
            Spacer()
        }
        .padding([.top, .bottom], 48)
        .background(Color(white: 0.925))
    }
}

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView(addingTask: .constant(false), addingList: .constant(true))
    }
}

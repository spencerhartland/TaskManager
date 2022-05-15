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
    @State var listName: String = ""
    @State var listSymbol: SFSymbol = SFSymbol(name: "nil")
    
    var body: some View {
        VStack {
            SecondaryTitleView("Add List", addingTask: $addingTask, addingList: $addingList)
                .foregroundColor(Color(white:0.15))
            SimpleTextField("LIST", prompt: "What would you like to call this list?", userText: $listName)
                .padding(.top, 32)
            SymbolSelectionView(selectedSymbol: $listSymbol)
                .padding(.top, 48)
            Spacer()
            LargeButton(action: {
                let testList = TaskList(listName, symbol: listSymbol)
                print(testList.name)
                print(testList.symbol.name)
            })
        }
        .padding([.top], 48)
        .background(Color(white: 0.925))
    }
}

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView(addingTask: .constant(false), addingList: .constant(true))
    }
}

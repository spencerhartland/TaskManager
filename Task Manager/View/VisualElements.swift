//
//  VisualElements.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/10/22.
//

import SwiftUI

/// Top UI of every view.
///
/// Consists of a large header with SF Symbol and a button to add a List or Task.
struct TitleView: View {
    /// The page's title.
    private var title: String = ""
    /// The name of an SF Symbol that represents the page's content.
    private var viewIconName: String = ""
    /// An SF Symbol: a plus sign within a filled square.
    private var addSymbol = Image(systemName: "plus.square.fill")
    /// A boolean value indicating whether or not to present the floating action menu.
    @State private var isExpanded = false
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingTask: Bool
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingList: Bool
    
    /// Initializer for `PageTitle`.
    ///
    /// - Parameters:
    ///     - pageTtile: The title of the page.
    ///     - systemImageName: The name of an SF Symbol that represents the page's content.
    init(_ pageTitle: String, systemImageName: String, addingTask: Binding<Bool>, addingList: Binding<Bool>) {
        self.title = pageTitle
        self.viewIconName = systemImageName
        self._addingList = addingList
        self._addingTask = addingTask
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Image(systemName: viewIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48)
                Text(title)
                    .font(.system(size: 36, weight: .semibold))
            }
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
        }
        .padding([.leading, .trailing], 24)
    }
}

/// A list of tasks to be completed in a timely manner.
///
/// The list displays tasks for which the user has indicated a timeframe in which the task should be
/// completed. The user can choose from three timeframe options: today, by the end of the week, or by
/// the end of the month.
struct TimeBasedTaskList: View {
    /// The list's title. Based on the `timeframe` set.
    private var title: String = ""
    /// The timeframe in which the tasks in this list should be completed.
    private var timeframe: timeframe
    
    init(_ tf: timeframe) {
        switch tf {
        case .today:
            self.title = "TODAY"
        case .endOfWeek:
            self.title = "END OF WEEK"
        case .endOfMonth:
            self.title = "END OF MONTH"
        }
        self.timeframe = tf
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .padding(.leading, 18.0)
            }
            List(tasks) { task in
                if task.timeframe == self.timeframe {
                    ListItemView(task)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .offset(y: -8)
        }
    }
}

struct ListItemView: View {
    private let squareSymbol = Image(systemName: "square")
    private let checkmarkSquareSymbol = Image(systemName: "checkmark.square.fill")
    
    @State private var task: Task
    
    init(_ task: Task) {
        self.task = task
    }
    
    var body: some View {
        Button(action: {
            task.completed.toggle()
            task.saveToCloud()
        }, label: {
            HStack {
                (task.completed ? checkmarkSquareSymbol : squareSymbol)
                    .font(.system(size: 24))
                Text(task.text)
                    .font(.system(size: 16, weight: .medium))
            }
        })
        .foregroundColor(Color(white: 0.45))
        .listRowBackground(Color(white: 1.0, opacity: 0.0))
    }
}

struct SecondaryTitleView: View {
    /// The title of this secondary page.
    private var title: String = ""
    /// A boolean value indicating whether or not the user is currently adding a **task**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingTask: Bool
    /// A boolean value indicating whether or not the user is currently adding a **list**.
    ///
    /// This value is used to determine which view is being presented.
    @Binding var addingList: Bool
    
    init(_ title: String, addingTask: Binding<Bool>, addingList: Binding<Bool>) {
        self.title = title
        self._addingList = addingList
        self._addingTask = addingTask
    }
    
    var body: some View {
        Button {
            if addingTask { addingTask = !addingTask }
            else if addingList { addingList = !addingList }
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "xmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 36)
                Text(title)
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
            }
        }
        .padding([.leading, .trailing], 24)
    }
}

struct SimpleTextField: View {
    private let titleText: String
    private let promptText: String
    @State private var userText: String = ""
    
    init(_ title: String, prompt: String) {
        self.titleText = title
        self.promptText = prompt
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titleText)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
            ZStack {
                Color.white
                TextField(text: $userText, prompt: Text(promptText), label: {
                    Text(promptText)
                })
                .padding([.leading, .trailing], 16) // Space around prompt text
            }
            .frame(height: 48)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .shadow(color: .init(white: 0.85), radius: 6)
        }
        .padding([.leading, .trailing], 24) // Space around TextField and title
    }
}

struct VisualElements_Previews: PreviewProvider {
    static var previews: some View {
//        TitleView("Dashboard", systemImageName: "list.bullet.rectangle.fill", addingTask: .constant(false), addingList: .constant(false))
//        TimeBasedTaskList(.today)
//        TimeBasedTaskList(.endOfWeek)
//        SecondaryTitleView("Add List", addingTask: .constant(false), addingList: .constant(true))
        SimpleTextField("LIST", prompt: "What would you like to call this list?")
        SimpleTextField("TASK", prompt: "What do you have to do?")
    }
}

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
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: viewIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48)
            Text(title)
                .font(.system(size: 36, weight: .semibold))
        }
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
    @Binding var tasks: [Task]
    
    init(_ tf: timeframe, tasks: Binding<[Task]>) {
        switch tf {
        case .today:
            self.title = "TODAY"
        case .endOfWeek:
            self.title = "END OF WEEK"
        case .endOfMonth:
            self.title = "END OF MONTH"
        }
        self.timeframe = tf
        self._tasks = tasks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            ForEach(tasks) { task in
                // "Today" list should show complete and incomplete
                // tasks. Other lists should hide completed tasks.
                if (task.timeframe == self.timeframe) && (task.timeframe == .today || !task.completed) {
                    ListItemView(task)
                        .listRowSeparator(.hidden)
                }
            }
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
    @Binding public var userText: String
    
    init(_ title: String, prompt: String, userText: Binding<String>) {
        self.titleText = title
        self.promptText = prompt
        self._userText = userText
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titleText)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
            ZStack {
                Color.white
                    .shadow(color: .init(white: 0.85), radius: 4)
                    .cornerRadius(8)
                TextField(text: $userText, prompt: Text(promptText), label: {
                    Text(promptText)
                })
                .padding([.leading, .trailing], 16) // Space around prompt text
            }
            .frame(height: 48)
            .aspectRatio(contentMode: .fit)
        }
        .padding([.leading, .trailing], 24) // Space around TextField and title
    }
}

struct SymbolSelectionView: View {
    let columns = [ GridItem(.adaptive(minimum: 48)) ]
    @Binding public var selectedSymbol: SFSymbol
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SYMBOL")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(TaskStore.symbols, id: \.self) { symbol in
                    SymbolButton(symbol: symbol, selectedSymbol: $selectedSymbol)
                }
            }
        }
        .padding([.leading, .trailing], 24)
    }
}

struct SymbolButton: View {
    var symbol: SFSymbol
    @Binding var selectedSymbol: SFSymbol
    
    var body: some View {
        Button {
            selectedSymbol = symbol
        } label: {
            ZStack {
                symbol.name == selectedSymbol.name ? Color.init(white: 0.15) : Color.white
                Image(systemName: symbol.name)
                    .resizable()
                    .padding(6)
                    .foregroundColor((symbol.name == selectedSymbol.name ? Color.white : Color.init(white: 0.15)))
            }
            .frame(height: 48)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .shadow(color: .init(white: 0.85), radius: 6)
        }
    }
}

struct LargeButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.init(white: 0.15)
                    .frame(height: 50)
                    .cornerRadius(10)
                    .shadow(color: .init(white: 0.45), radius: 6)
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding([.leading, .trailing], 36)
            .foregroundColor(.white)
        }
    }
}

struct VisualElements_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(action: {
            print("Hello, world!")
        })
    }
}

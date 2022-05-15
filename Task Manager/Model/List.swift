//
//  List.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/12/22.
//

import Foundation
import SwiftUI

struct SFSymbol: Hashable, Codable {
    public var name: String = ""
}

class TaskList {
    public var name: String
    public var symbol: SFSymbol
    
    private var tasks: [Task]
    
    init(_ name: String, symbol: SFSymbol) {
        self.name = name
        self.symbol = symbol
        self.tasks = [Task]()
    }
}

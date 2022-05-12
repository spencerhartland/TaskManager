//
//  Tasks.swift
//  Task Manager
//
//  Created by Spencer Hartland on 5/10/22.
//
import Foundation
import CloudKit


enum timeframe: String, Codable {
    case today = "today"
    case endOfWeek = "endOfWeek"
    case endOfMonth = "endOfMonth"
}

struct Task: Hashable, Codable, Identifiable {
    public var id: Int
    public var timeframe: timeframe
    public var text: String
    public var details: String
    public var completed: Bool
    
    init(identifier: Int, _ taskText: String, taskDetails: String?, completeBy: timeframe) {
        self.id = identifier
        self.text = taskText
        self.details = taskDetails != nil ? taskDetails! : ""
        self.timeframe = completeBy
        self.completed = false
    }
    
    mutating func toggleCompletion() {
        completed = !completed
    }
    
    func saveToCloud() {
        let record = CKRecord(recordType: "task")
        record.setValuesForKeys([
            "id": self.id,
            "timeframe": self.timeframe.rawValue,
            "text": self.text,
            "details": self.details,
            "completed": self.completed
        ])
        let container = CKContainer.default()
        let database = container.privateCloudDatabase
        database.save(record) { record, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("Record saved successfully.")
            }
        }
    }
    
}

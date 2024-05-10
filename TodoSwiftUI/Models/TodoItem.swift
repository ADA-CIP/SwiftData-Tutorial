//
//  TodoItem.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import Foundation
import SwiftData

@Model class TodoItem: Identifiable, Equatable {
    var title: String
    var completed: Bool = false
    var createdAt: Date = Date()
    var finishedAt: Date?
    
    //@Relationship(inverse: Todo.self) var todo: Todo
    
    init(title: String) {
        self.title = title
    }
    
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
    
    var finishedAtString: String {
        guard let finishedAt = finishedAt else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: finishedAt)
    }
}

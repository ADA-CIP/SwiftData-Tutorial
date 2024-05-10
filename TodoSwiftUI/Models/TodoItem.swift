//
//  TodoItem.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import Foundation

struct TodoItem: Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var completed: Bool = false
    var createdAt: Date = Date()
    var finishedAt: Date?
    
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

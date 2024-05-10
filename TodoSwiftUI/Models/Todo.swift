//
//  Todo.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import Foundation
import SwiftData

@Model class Todo: Identifiable {
    var title: String
    var createdAt: Date = Date()
    
    init(title: String) {
        self.title = title
    }
    
    @Relationship(deleteRule: .cascade) var items: [TodoItem] = []
    
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
}

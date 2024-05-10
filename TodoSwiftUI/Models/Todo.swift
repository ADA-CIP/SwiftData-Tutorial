//
//  Todo.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import Foundation

extension Todo {
    static var data: [Todo] {
        [
            Todo(title: "Learn Swift", items: [
                TodoItem(title: "Learn about SwiftUI"),
                TodoItem(title: "Learn about Combine")
            ]),
            Todo(title: "Learn iOS", items: [
                TodoItem(title: "Learn about UIKit"),
                TodoItem(title: "Learn about Core Data")
            ]),
            Todo(title: "Learn Android", items: [
                TodoItem(title: "Learn about Kotlin"),
                TodoItem(title: "Learn about Jetpack")
            ]),
        ]
    }
}

struct Todo: Identifiable {
    var id: UUID = UUID()
    var title: String
    var createdAt: Date = Date()
    
    var items: [TodoItem] = []
    
    var createdAtString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
}

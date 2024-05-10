//
//  ModelContainer.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import Foundation
import SwiftData

@MainActor
class AppModelContainer {
    static let container: ModelContainer = {
        
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Todo.self, TodoItem.self, configurations: config)
            createDummyData(container: container)
            return container
        } catch {
            fatalError("Container not initialized")
        }
    }()
    
    static func createDummyData(container: ModelContainer) {
        for i in 1...5 {
            let todo = Todo(title: "Todo \(i)")
            container.mainContext.insert(todo)
            
            for j in 1...10 {
                let item = TodoItem(title: "Item no \(j)")
                todo.items.append(item)
            }
        }
        
        try? container.mainContext.save()
    }
}

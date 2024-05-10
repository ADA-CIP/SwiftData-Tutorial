//
//  TodoSwiftUIApp.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import SwiftUI
import SwiftData

@main
struct TodoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [Todo.self, TodoItem.self])
    }
}

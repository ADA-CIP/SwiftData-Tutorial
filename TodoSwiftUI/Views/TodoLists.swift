//
//  TodoLists.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import SwiftUI
import SwiftData

struct TodoLists: View {
    @Environment(\.modelContext) var modelContext
    @Query var todoList: [Todo]
    
    var body: some View {
        List(todoList) { todo in
            NavigationLink(destination: TodoDetailView(todo: todo)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(todo.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(todo.createdAtString)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Todos")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let todo = Todo(title: "New todo")
                    modelContext.insert(todo)
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(AppModelContainer.container)
}

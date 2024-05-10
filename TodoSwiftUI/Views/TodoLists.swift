//
//  TodoLists.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import SwiftUI

struct TodoLists: View {
    @State var todoLists: [Todo] = Todo.data
    @State var selectedTodo: Todo?
    @State var isDetailPresented = false
    
    var body: some View {
        List(todoLists) { todo in
            Button {
                selectedTodo = todo
                isDetailPresented = true
            } label: {
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
        .navigationDestination(isPresented: $isDetailPresented) {
            TodoDetailView(todo: selectedTodo)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    todoLists.append(Todo(
                        title: "New Todo",
                        createdAt: Date()
                    ))
                    isDetailPresented = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

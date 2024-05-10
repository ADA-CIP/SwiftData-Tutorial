//
//  TodoDetailView.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import SwiftUI
import SwiftData

struct TodoDetailView: View {
    @Bindable var todo: Todo
    
    @State var title: String = ""
    @State var newItemTitle: String = ""
    @State var showNewItemAlert: Bool = false
    
    var pendingOnly: [TodoItem] {
        todo.items.filter { !$0.completed }
    }
    
    var completedOnly: [TodoItem] {
        todo.items.filter { $0.completed }
    }
    
    var body: some View {
        List {
            Section {
                TextField("Title", text: $title)
                    .font(.title2)
                    .onChange(of: title) {
                        todo.title = title
                    }
            }
            
            Section {
                ForEach(pendingOnly) { item in
                    Button(action: {
                        withAnimation(.spring()) {
                            if let index = todo.items.firstIndex(of: item) {
                                finish(index: index)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: item.completed
                                  ? "checkmark.circle.fill"
                                  : "circle"
                            ).foregroundColor(
                                item.completed
                                ? .accentColor
                                : .secondary
                            ).font(.title2)
                            
                            Text(item.title)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .onDelete { indexSet in
                    todo.items.remove(atOffsets: indexSet)
                }
            } header: {
                Text("Pending")
                    .font(.headline)
            }
            
            Section {
                ForEach(completedOnly) { item in
                    Button(action: {
                        withAnimation(.spring()) {
                            if let index = todo.items.firstIndex(of: item) {
                                unfinish(index: index)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName:
                                    item.completed
                                  ? "checkmark.circle.fill"
                                  : "circle"
                            ).foregroundColor(
                                item.completed
                                ? .accentColor
                                : .secondary
                            )
                            .font(.title2)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .strikethrough()
                                
                                Text(item.finishedAtString)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    todo.items.remove(atOffsets: indexSet)
                }
            } header: {
                Text("Completed")
                    .font(.headline)
            }
        }
        .navigationBarTitle("Detail", displayMode: .inline)
        .alert("New Todo Item", isPresented: $showNewItemAlert) {
            TextField("Title", text: $newItemTitle)
            Button("Save", action: {
                withAnimation(.spring()) {
                    todo.items.append(TodoItem(title: newItemTitle))
//                    showNewItemAlert = false
                }
            })
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Enter a title for the new todo item.")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newItemTitle = ""
                    showNewItemAlert = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func finish(index: Int) {
        
        todo.items[index].finishedAt = Date()
        todo.items[index].completed.toggle()
    }
    
    func unfinish(index: Int) {
        todo.items[index].finishedAt = nil
        todo.items[index].completed.toggle()
    }
}

#Preview {
    
    struct PreviewItem: View {
        @Query var todos: [Todo]
        
        var body: some View {
            TodoDetailView(todo: todos.first!)
        }
    }
    
    return PreviewItem()
        .modelContainer(AppModelContainer.container)
}

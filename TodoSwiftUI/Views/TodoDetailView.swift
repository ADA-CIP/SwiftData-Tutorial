//
//  TodoDetailView.swift
//  TodoSwiftUI
//
//  Created by Rama Adi Nugraha on 10/05/24.
//

import SwiftUI

struct TodoDetailView: View {
    var todo: Todo?
    
    @State var title: String = ""
    @State var items: [TodoItem] = []
    
    @State var newItemTitle: String = ""
    @State var showNewItemAlert: Bool = false
    
    var pendingOnly: [TodoItem] {
        items.filter { !$0.completed }
    }
    
    var completedOnly: [TodoItem] {
        items.filter { $0.completed }
    }
    
    var body: some View {
        List {
            Section {
                TextField("Title", text: $title)
                    .font(.title2)
            }
            
            Section {
                ForEach(pendingOnly) { item in
                    Button(action: {
                        withAnimation(.spring()) {
                            if let index = items.firstIndex(of: item) {
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
                    items.remove(atOffsets: indexSet)
                }
            } header: {
                Text("Pending")
                    .font(.headline)
            }
            
            Section {
                ForEach(completedOnly) { item in
                    Button(action: {
                        withAnimation(.spring()) {
                            if let index = items.firstIndex(of: item) {
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
                    items.remove(atOffsets: indexSet)
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
                    if !newItemTitle.isEmpty {
                        items.append(TodoItem(title: newItemTitle))
                    }
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
        .onAppear {
            title = todo?.title ?? ""
            items = todo?.items ?? []
        }
    }
    
    func finish(index: Int) {
        items[index].finishedAt = Date()
        items[index].completed.toggle()
    }
    
    func unfinish(index: Int) {
        items[index].finishedAt = nil
        items[index].completed.toggle()
    }
}

#Preview {
    TodoDetailView(todo: Todo.data.first!)
}

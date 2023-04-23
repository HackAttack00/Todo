//
//  ContentView.swift
//  Todo
//
//  Created by Seungchul Lee on 2023/03/26.
//

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
    var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationView {
            ZStack {
                List{
                    ForEach(self.todos, id:\.self) { todo in
                        HStack {
                            Text(todo.name ?? "unknown")
                            Spacer()
                            Text(todo.priority ?? "unknown")
                        }
                        
                    }
                    .onDelete(perform: deleteTodo)
                }
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView()
                    }
                )
                // MARK: NO todo item
                if (self.todos.count == 0) {
                    Text("Empty List")
                }
            } //ZSTACK
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("켜짐")
            case .inactive:
                print("꺼짐")
            case .background:
                print("백그라운드에서 돌아가는 중")
            default:
                print("뭐지")
            }
        }
    }
    
    func enterBackground() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = (UIApplication.shared.delegate as!
//                       AppDelegate).persistentContainer.viewContext
//        return ContentView()
//            .environment(\.managedObjectContext, context)
//            .previewContext("iphoen 12 pro")
//    }
//}

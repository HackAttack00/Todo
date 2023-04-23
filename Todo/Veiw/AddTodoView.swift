//
//  AddTodoView.swift
//  Todo
//
//  Created by Seungchul Lee on 2023/03/28.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["high", "normal", "low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //Text("Hellow, world")
                    TextField("Todo", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Button {
                        print("Save a new Todo item")
                        if self.name != "" {
                            let todo = Todo(context:self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                                print("new todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "invalid name"
                            self.errorMessage = "make sure to enter something for \n the new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                Spacer()
            }
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddTodoView_Preview: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewDevice("iPhone 11 Pro")
    }
}


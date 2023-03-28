//
//  AddTodoView.swift
//  Todo
//
//  Created by Seungchul Lee on 2023/03/28.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["high", "normal", "low"]
    
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
        }
    }
}

struct AddTodoView_Preview: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewDevice("iPhone 11 Pro")
    }
}

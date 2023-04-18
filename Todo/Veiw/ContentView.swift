//
//  ContentView.swift
//  Todo
//
//  Created by Seungchul Lee on 2023/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddTodoView: Bool = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationView {
            List(0..<5) { item in
                Text("Hello")
            }
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddTodoView) {
                    AddTodoView()
                }
            )
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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

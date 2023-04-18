//
//  TodoApp.swift
//  Todo
//
//  Created by Seungchul Lee on 2023/03/26.
//

import SwiftUI

@main
struct TodoApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

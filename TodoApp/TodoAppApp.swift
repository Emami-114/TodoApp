//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Ecc on 01.08.23.
//

import SwiftUI

@main
struct TodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            let context = PersistenceController.shared.container.viewContext
            let dataHolder = DataHolder(context)
            TaskListView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(dataHolder)
        }
    }
}

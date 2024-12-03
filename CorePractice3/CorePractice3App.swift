//
//  CorePractice3App.swift
//  CorePractice3
//
//  Created by Steve Howard on 2024/12/2.
//

import SwiftUI

import CoreData

@main
struct CorePractice3App: App {
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData3")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

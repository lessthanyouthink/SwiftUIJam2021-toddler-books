//
//  ToddlerBookTrackerApp.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-19.
//

import SwiftUI

@main
struct ToddlerBookTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                BookList()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

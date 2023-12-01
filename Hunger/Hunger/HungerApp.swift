//
//  HungerApp.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-14.
//

import SwiftUI

@main
struct HungerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(LocalSearchService())
                .environmentObject(HungerVM())
        }
    }
}

//
//  learnIOSApp.swift
//  learnIOS
//
//  Created by eternity6666 on 2023/6/28.
//

import SwiftUI

@main
struct learnIOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  PerpetualApp.swift
//  Perpetual
//
//  Created by Caleb Elson on 9/16/21.
//

import SwiftUI

@main
struct PerpetualApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

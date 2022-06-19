//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Bouchedoub Rmazi on 5/5/2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

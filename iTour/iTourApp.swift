//
//  iTourApp.swift
//  iTour
//
//  Created by Jordon Bigelow on 6/18/24.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}

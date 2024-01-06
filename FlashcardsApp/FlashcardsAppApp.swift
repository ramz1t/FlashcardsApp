//
//  FlashcardsAppApp.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 07.11.2023.
//

import SwiftUI
import SwiftData

@main
struct FlashcardsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Card.self])
    }
}

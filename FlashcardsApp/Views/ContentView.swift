//
//  ContentView.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 07.11.2023.
//

import SwiftUI
import SwiftData
import LocalAuthentication

struct ContentView: View {
    @AppStorage("requirePassword") private var requirePassword = false
    
    var body: some View {
        ZStack {
            MainView()
            if requirePassword {
                LockedView()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}

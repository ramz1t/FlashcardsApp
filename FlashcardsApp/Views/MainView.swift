//
//  Main.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 11.01.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var search = ""
    @State private var searchIsActive = false
    @State private var order = SortDescriptor(\Card.creationDate, order: .reverse)
    @State private var addCardIsOpen = false
    @State private var settingsIsOpen = false
    
    var body: some View {
        NavigationStack {
            CardsList(sort: order, search: search, searchIsActive: $searchIsActive)
                .navigationTitle("Flashcards")
                .searchable(text: $search,
                            isPresented: $searchIsActive,
                            placement: .navigationBarDrawer(displayMode: .always)
                )
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button {
                            settingsIsOpen = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItemGroup(placement: .primaryAction) {
                        sortMenu
                        Button {
                            addCardIsOpen = true
                        } label: {
                            Image(systemName: "plus.rectangle.on.rectangle")
                        }
                        
                    }
                    ToolbarItem(placement: .bottomBar) {
                        authorLink
                    }
                }
                .sheet(isPresented: $addCardIsOpen) {
                    CreateCardView()
                }
                .sheet(isPresented: $settingsIsOpen) {
                    SettingsView()
                }
        }
    }
    
    var sortMenu: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $order) {
                Label("Original text", systemImage: "doc.text")
                    .tag(SortDescriptor(\Card.originalText))
                Label("Translated text", systemImage: "text.book.closed")
                    .tag(SortDescriptor(\Card.translatedText))
                Label("Creation date", systemImage: "calendar")
                    .tag(SortDescriptor(\Card.creationDate, order: .reverse))
            }
            .pickerStyle(.inline)
        }
    }
    
    var authorLink: some View {
        Link(destination: URL(string: "https://github.com/ramz1t/tictactoe")!, label: {
            HStack(spacing: 5) {
                Text("Made by Ramz1 🇸🇪")
                Image(systemName: "arrow.up.forward.app")
            }
            .foregroundStyle(.secondary)
            .fontDesign(.rounded)
            .bold()
        })
        .foregroundStyle(.secondary)
        .fontDesign(.rounded)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    return MainView()
        .modelContainer(container)
}
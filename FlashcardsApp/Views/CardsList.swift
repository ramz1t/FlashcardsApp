//
//  WordsList.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 15.12.2023.
//

import SwiftUI
import SwiftData

struct CardsList: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("showTranslations") private var showingTranslations = false
    
    @ObservedObject var viewModel: CardsViewModel
    
    var body: some View {
        List {
            if !viewModel.cards.isEmpty {
                Section {
                    Button {
                        showingTranslations.toggle()
                    } label: {
                        Label(showingTranslations ? "Hide translations" : "Show translations", systemImage: showingTranslations ? "eye" : "eye.slash")
                    }
                    ForEach(viewModel.cards) { card in
                        CardListCell(card: card,
                                     showTranslation: showingTranslations,
                                     viewModel: viewModel)
                    }
                } header: {
                    Text(viewModel.cards.count == 1 ? "1 card" : "\(viewModel.cards.count) cards")
                } footer: {
                    Text("Swipe left to edit a card")
                }
            }
        }
        .scrollDisabled(viewModel.cards.isEmpty)
        .overlay {
            if viewModel.cards.isEmpty {
                if viewModel.searchIsActive {
                    ContentUnavailableView.search(text: viewModel.searchQuery.trimmingCharacters(in: .whitespaces))
                } else {
                    ContentUnavailableView("Wordlist Is Empty", systemImage: "doc.text.magnifyingglass", description: Text("Add Cards to begin practicing every day"))
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    @ObservedObject var viewModel = CardsViewModel()
    
    return NavigationStack {
        CardsList(viewModel: viewModel)
            .searchable(text: $viewModel.searchQuery,
                        placement: .navigationBarDrawer(displayMode: .always))
            .modelContainer(container)
    }
}

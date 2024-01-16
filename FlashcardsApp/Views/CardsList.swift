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
    @Binding private var searchIsActive: Bool
    var search = ""
    
    @Query var cards: [Card]
    
    init(sort: SortDescriptor<Card>, search: String, searchIsActive: Binding<Bool>) {
        let clearSearch = search.trimmingCharacters(in: .whitespacesAndNewlines)
        _cards = Query(filter: #Predicate<Card> {
            if clearSearch.isEmpty {
                return true
            } else {
                return $0.originalText.localizedStandardContains(clearSearch) || $0.translatedText.localizedStandardContains(clearSearch)
            }
        }, sort: [sort])
        _searchIsActive = searchIsActive
        self.search = search
    }
    
    var body: some View {
        List {
            if !cards.isEmpty {
                Section {
                    Button {
                        showingTranslations.toggle()
                    } label: {
                        Label(showingTranslations ? "Hide translations" : "Show translations", systemImage: showingTranslations ? "eye" : "eye.slash")
                    }
                    ForEach(cards) { card in
                        CardListCell(card: card, showTranslation: $showingTranslations)
                    }
                } header: {
                    Text(cards.count == 1 ? "1 card" : "\(cards.count) cards")
                } footer: {
                    Text("Swipe left to edit a card")
                }
            }
        }
        .scrollDisabled(cards.isEmpty)
        .overlay {
            if cards.count == 0 {
                if searchIsActive {
                    ContentUnavailableView.search(text: search)
                } else {
                    ContentUnavailableView("Wordlist Is Empty", systemImage: "doc.text.magnifyingglass", description: Text("Add Cards to begin practicing every day"))
                }
            }
        }
    }
}

#Preview {
    @State var search = ""
    @State var active = false
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    return NavigationStack {
        CardsList(sort: SortDescriptor(\Card.originalText), search: search, searchIsActive: $active)
            .searchable(text: $search,
                        placement: .navigationBarDrawer(displayMode: .always))
            .modelContainer(container)
    }
}

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
    
    @Query var cards: [Card]
    
    init(sort: SortDescriptor<Card>, search: String, searchIsActive: Binding<Bool>) {
        _cards = Query(filter: #Predicate<Card> {
            if search.isEmpty {
                return true
            } else {
                return $0.originalText.localizedStandardContains(search) || $0.translatedText.localizedStandardContains(search)
            }
        }, sort: [sort])
        _searchIsActive = searchIsActive
    }
    
    var body: some View {
        List {
            if cards.count > 0 {
                Section {
                    Button {
                        showingTranslations.toggle()
                    } label: {
                        Label(showingTranslations ? "Hide translations" : "Show translations", systemImage: showingTranslations ? "eye" : "eye.slash")
                    }
                    ForEach(cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.originalText)
                            if showingTranslations {
                                Text(card.translatedText)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(card)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            NavigationLink {
                                EditCardView(card: card)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                } header: {
                    Text(cards.count == 1 ? "1 card" : "\(cards.count) cards")
                } footer: {
                    Text("Swipe left to edit a card")
                }
            }
        }
        .scrollDisabled(cards.count == 0)
        .overlay {
            if cards.count == 0 {
                NoContentView(icon: "doc.text.magnifyingglass",
                              title: "No Cards Found",
                              description: searchIsActive ? nil : "Add Cards to begin practicing every day")
            }
        }
    }
}

#Preview {
    @State var search = ""
    @State var active = false
    return NavigationStack {
        CardsList(sort: SortDescriptor(\Card.originalText), search: search, searchIsActive: $active)
            .searchable(text: $search,
                        placement: .navigationBarDrawer(displayMode: .always))
    }
}

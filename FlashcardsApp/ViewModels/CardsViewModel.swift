//
//  CardsViewModel.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 22.01.2024.
//

import Foundation
import SwiftData

class CardsViewModel: ObservableObject {
    var modelContext: ModelContext?
    @Published var searchQuery: String = "" {
        didSet {
            fetchCards()
        }
    }
    @Published var searchIsActive: Bool = false {
        didSet {
            fetchCards()
        }
    }
    @Published var sort: SortDescriptor<Card> = SortDescriptor(\.creationDate, order: .reverse) {
        didSet {
            fetchCards()
        }
    }
    @Published var cards: [Card] = []
    
    func fetchCards() {
        let descriptor = FetchDescriptor<Card>(
            predicate: #Predicate<Card> {
                searchQuery.isEmpty ||
                $0.originalText.localizedStandardContains(searchQuery) ||
                $0.translatedText.localizedStandardContains(searchQuery)
            }, sortBy: [sort]
        )
        
        cards = (try? (modelContext?.fetch(descriptor) ?? [])) ?? []
    }
    
    func addCard(originalText: String, translatedText: String) {
        let card = Card(originalText: originalText, translatedText: translatedText)
        
        modelContext?.insert(card)
        try? modelContext?.save()
        
        fetchCards()
    }
    
    func deleteCard(_ card: Card) {
        modelContext?.delete(card)
        fetchCards()
    }
}



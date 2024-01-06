//
//  EditCardView.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 18.12.2023.
//

import SwiftUI
import SwiftData

struct EditCardView: View {
    @Bindable var card: Card
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $card.originalText)
                } header: {
                    Label("Original text", systemImage: "a.book.closed")
                }
                Section {
                    TextField("", text: $card.translatedText)
                } header: {
                    Label("Translated text", systemImage: "a.book.closed.ja")
                }
            }
            .navigationTitle("Edit Card")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    let card = Card(originalText: "Original", translatedText: "Translated")
    
    return EditCardView(card: card)
        .modelContainer(container)
}

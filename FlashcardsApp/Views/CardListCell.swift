//
//  CardListCell.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 16.01.2024.
//

import SwiftUI
import SwiftData

struct CardListCell: View {
    let card: Card
    @Binding var showTranslation: Bool
    @State var editMenuOpen = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.translatedText)
            if showTranslation {
                Text(card.originalText)
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
            Button {
                editMenuOpen = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
        .sheet(isPresented: $editMenuOpen) {
            EditCardView(card: card)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    let card = Card()
    @State var showingTranslation = false
    
    return CardListCell(card: card, showTranslation: $showingTranslation)
}

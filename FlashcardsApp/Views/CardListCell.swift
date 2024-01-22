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
    @ObservedObject var viewModel: CardsViewModel
    
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
                viewModel.deleteCard(card)
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
    @StateObject var viewModel = CardsViewModel()
    
    return CardListCell(card: card, showTranslation: $showingTranslation, viewModel: viewModel)
}

//
//  CreateCardView.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 17.12.2023.
//

import SwiftUI

struct CreateCardView: View {
    @State private var originalText = ""
    @State private var translatedText = ""
    var canSave: Bool {
        originalText.trimmingCharacters(in: .whitespaces) != "" && 
        translatedText.trimmingCharacters(in: .whitespaces) != ""
    }
    @ObservedObject var viewModel: CardsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $originalText)
                } header: {
                    Label("Original text", systemImage: "a.book.closed")
                }
                Section {
                    TextField("", text: $translatedText)
                } header: {
                    Label("Translated text", systemImage: "a.book.closed.ja")
                }
            }
            .navigationTitle("Create New Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        viewModel.addCard(originalText: originalText, 
                                          translatedText: translatedText)
                        dismiss()
                    }
                    .bold()
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    @ObservedObject var viewModel = CardsViewModel()
    return CreateCardView(viewModel: viewModel)
}

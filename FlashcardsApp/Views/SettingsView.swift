//
//  Settings.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 11.01.2024.
//

import SwiftUI
import SwiftData
import UIKit

struct SettingsView: View {
    @AppStorage("requirePassword") var requirePassword: Bool = false
    @Environment(\.modelContext) var modelContext
    @State private var isPresentingDialog = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Button(requirePassword ? "Remove Password" : "Use Password") {
                    
                }
                Button("Clear All Words", role: .destructive) {
                    isPresentingDialog = true
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("Are you sure?", isPresented: $isPresentingDialog) {
                Button("Delete", role: .destructive) {
                    UIDevice.authenticate {
                        try! modelContext.delete(model: Card.self)
                    }
                }
            } message: {
                Text("Are you sure you want to delete all your words? You can not undo this action")
            }
            .toolbar {
                Button("Close") {
                    dismiss()
                }
                .bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

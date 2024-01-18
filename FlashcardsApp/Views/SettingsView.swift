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
    @AppStorage("requirePassword") private var requirePassword = false
    @AppStorage("shakeToLock") private var shakeToLock = false
    @Environment(\.modelContext) var modelContext
    @State private var isPresentingDialog = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        if !requirePassword {
                            UIDevice.authenticate {
                                requirePassword = true
                            }
                        } else {
                            requirePassword = false
                        }
                    } label: {
                        Label(requirePassword ? "Remove Face ID" : "Use Face ID", systemImage: "faceid")
                            .foregroundStyle(.green)
                    }
                    Toggle(isOn: $shakeToLock) {
                        Label("Shake To Lock", systemImage: "waveform.path")
                    }
                } header: {
                    Text("Settings")
                } footer: {
                    Text("Use Face ID to unlock the app and perform permanent actions")
                }
                Section {
                    Button(role: .destructive) {
                        isPresentingDialog = true
                    } label: {
                        Label("Clear All Words", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
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

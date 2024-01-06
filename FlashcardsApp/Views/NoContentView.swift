//
//  NoContentView.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 09.11.2023.
//

import SwiftUI

struct NoContentView: View {
    let icon: String?
    let title: String?
    let description: String?
    
    init(icon: String? = nil, title: String? = nil, description: String? = nil) {
        self.icon = icon
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack() {
            if let icon {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.accent)
            }
            if let title {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(.vertical, 10)
            }
            if let description {
                Text(description)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    NoContentView(icon:"exclamationmark.triangle",
                  title: "Alert",
                  description: "No content available")
}

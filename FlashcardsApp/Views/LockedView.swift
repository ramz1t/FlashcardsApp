//
//  LockedView.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 10.01.2024.
//

import SwiftUI
import UIKit

struct LockedView: View {
    @State private var isLocked = true
    @AppStorage("shakeToLock") private var shakeToLock = false
    
    var body: some View {
        if isLocked {
            VStack {
                Image(systemName: "lock")
                    .font(.largeTitle)
                    .foregroundStyle(.accent)
                Text(isLocked ? "Locked" : "Unlocked")
                    .padding()
                    .bold()
                    .font(.title)
                Button("Unlock") {
                    UIDevice.authenticate {
                        isLocked = false
                    }
                }
                .buttonStyle(.bordered)
                
            }
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onShake {
                if shakeToLock {
                    isLocked = true
                }
            }
        }
    }
}

#Preview {
    LockedView()
}

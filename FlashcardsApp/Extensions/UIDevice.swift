//
//  Auth.swift
//  FlashcardsApp
//
//  Created by Timur Ramazanov on 11.01.2024.
//

import Foundation
import LocalAuthentication
import UIKit


extension UIDevice {
    static func authenticate(_ onSuccess: @escaping () -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use Face ID to lock the app so no one can modify your dictionary"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    onSuccess()
                }
            }
        } else {
            print("no biometrics")
        }
    }
}

//
//  File.swift
//
//
//  Created by Timur Ramazanov on 07.11.2023.
//

import Foundation
import SwiftData

@Model
class Card: Hashable {
    
    var originalText: String
    var translatedText: String
    var creationDate = Date.now
    
    init(originalText: String = "", translatedText: String = "") {
        self.originalText = originalText
        self.translatedText = translatedText
    }
    
}

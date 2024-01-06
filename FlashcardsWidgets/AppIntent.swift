//
//  AppIntent.swift
//  FlashcardsWidgets
//
//  Created by Timur Ramazanov on 20.12.2023.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Flashcards"
    static var description = IntentDescription("Add and practice everyday")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

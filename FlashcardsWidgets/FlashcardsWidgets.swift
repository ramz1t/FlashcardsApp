//
//  FlashcardsWidgets.swift
//  FlashcardsWidgets
//
//  Created by Timur Ramazanov on 20.12.2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct FlashcardsWidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label("Learned today -", systemImage: "character.book.closed.ja")
                Text("9")
            }
            .font(.system(size: 11))
            .foregroundStyle(.accent)
            Spacer()
            Text("Korv")
                .bold()
                .font(.title3)
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                ForEach(1..<4) { i in
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.accent)
                            Text("Option \(i)")
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .font(.subheadline)
        }
    }
}

struct FlashcardsWidgets: Widget {
    let kind: String = "FlashcardsWidgets"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            FlashcardsWidgetsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Practice Quiz")
        .description("Chooze the correct option. Counter resets every midnight")
    }
}

extension ConfigurationAppIntent {
    fileprivate static var start: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var end: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    FlashcardsWidgets()
} timeline: {
    SimpleEntry(date: .now, configuration: .start)
    SimpleEntry(date: .now, configuration: .end)
}

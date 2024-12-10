//
//  URLImageWidget.swift
//  WidgetExtension
//
//  Created by Pawel Wiszenko on 15.10.2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import WidgetKit

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let midnight = Calendar.current.startOfDay(for: Date())
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        let entries = [SimpleEntry(date: midnight)]
        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

private struct SimpleEntry: TimelineEntry {
    let date: Date
}

private struct URLImageWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if let imageURL, let data = try? Data(contentsOf: imageURL) {
            URLImageView(data: data)
                .aspectRatio(contentMode: .fill)
        }
    }

    private var imageURL: URL? {
        let path = "https://bkimg.cdn.bcebos.com/pic/e4dde71190ef76c63eda3e419f16fdfaaf516754"
        return URL(string: path)
    }
}

struct URLImageWidget: Widget {
    private let kind: String = WidgetKind.urlImage

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            URLImageWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("URLImage Widget")
        .description("A Widget that displays an Image downloaded from an external URL.")
        .supportedFamilies([.systemSmall])
    }
}

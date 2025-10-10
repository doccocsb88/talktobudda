//
//  AppIntent.swift
//  BuddaWidget
//
//  Created by mac on 10/10/25.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Buddha Quotes Widget" }
    static var description: IntentDescription { "Configure your Buddha quotes widget settings." }

    // Configuration for quote refresh frequency
    @Parameter(title: "Refresh Frequency", default: .every6Hours)
    var refreshFrequency: RefreshFrequency
    
    // Configuration for background style
    @Parameter(title: "Background Style", default: .gradient)
    var backgroundStyle: BackgroundStyle
}

enum RefreshFrequency: String, AppEnum {
    case every3Hours = "every3Hours"
    case every6Hours = "every6Hours"
    case every12Hours = "every12Hours"
    case daily = "daily"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Refresh Frequency"
    }
    
    static var caseDisplayRepresentations: [RefreshFrequency: DisplayRepresentation] {
        [
            .every3Hours: "Every 3 Hours",
            .every6Hours: "Every 6 Hours", 
            .every12Hours: "Every 12 Hours",
            .daily: "Daily"
        ]
    }
}

enum BackgroundStyle: String, AppEnum {
    case gradient = "gradient"
    case lotus = "lotus"
    case zen = "zen"
    case temple = "temple"
    case nature = "nature"
    case background01 = "bg-widget-01"
    case background02 = "bg-widget-02"
    case background03 = "bg-widget-03"
    case background04 = "bg-widget-04"
    case background05 = "bg-widget-05"

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Background Style"
    }
    
    static var caseDisplayRepresentations: [BackgroundStyle: DisplayRepresentation] {
        [
            .gradient: "Gradient",
            .lotus: "Lotus Pattern",
            .zen: "Zen Garden",
            .temple: "Temple",
            .nature: "Nature",
            .background01: "Background 01",
            .background02: "Background 02",
            .background03: "Background 03",
            .background04: "Background 04",
            .background05: "Background 05"
        ]
    }
}

//
//  WeatherellaApp.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Weatherella App
 */
@main
struct WeatherellaApp: App {
    
    @StateObject private var appWeatherData = AppWeatherData()
    
    var body: some Scene {
        WindowGroup {
            WeatherellaTabView()
            .environmentObject(appWeatherData)
        }
    }
}

//
//  WeatherellaApp.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

@main
struct ForecastApp: App {
    @StateObject private var appWeatherData = AppWeatherData()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(appWeatherData)
        }
    }
}

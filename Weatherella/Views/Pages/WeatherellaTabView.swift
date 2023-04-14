//
//  ForecastTabView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct WeatherellaTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("City", systemImage: "magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    Label("Weather Now", systemImage: "sun.max.fill")
                }
            HourlyView()
                .tabItem {
                    Label("Hourly", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    Label("AQI", systemImage: "aqi.high")
                }
        }
        .tint(.blue)
    }
}


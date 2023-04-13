//
//  Keys.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

enum WeatherAPI: String {
    
    case current = "weather"
    case forecast = "forecast"
    case pollution = "air_pollution"
    
    var url: String {
        let key = "14e55728c8186edec75cc13698249cbe"
        return "https://api.openweathermap.org/data/2.5/\(self.rawValue)?appid=\(key)&units=metric"
    }
    
//    var pollutionURL: String {
//        let key = "14e55728c8186edec75cc13698249cbe"
//        return "https://api.openweathermap.org/data/2.5/air_pollution?appid=\(key)"
//    }
}

enum AppStorageKeys {
    static let isFirstTimeUser: String = "appstorage.key.is-first-time-user"
}

enum MiscConstants {
    static let forecastJSONName = "london"
}

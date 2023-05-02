//
//  Keys.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
 Weather API
 */
enum APIConfigs: String {
    case currentWeatherAPI = "weather"
    case forecastWeatherAPI = "forecast"
    case pollutionAPI = "air_pollution"
    
    var baseURL: String {
        let key = "14e55728c8186edec75cc13698249cbe"
        return "https://api.openweathermap.org/data/2.5/\(self.rawValue)?appid=\(key)&units=metric"
    }
}

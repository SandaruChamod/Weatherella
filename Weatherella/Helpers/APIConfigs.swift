//
//  APIConfigs.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
 Weather API
 */
let key = "14e55728c8186edec75cc13698249cbe"

enum APIConfigs: String {
    case weatherAPI = "https://api.openweathermap.org/data/3.0/onecall"
    case pollutionAPI = "https://api.openweathermap.org/data/2.5/air_pollution"
    
    var baseURL: String {
        return "\(self.rawValue)?appid=\(key)&units=metric"
    }
}

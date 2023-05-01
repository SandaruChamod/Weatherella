//
//  WeatherCodables.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
 Forecast Weather Model
 */
struct ForecastWeatherModel: Identifiable {
    let id = UUID()
    let currentWeatherInfo: CurrentWeatherInfo
    let forecastWeatherInfo: ForecastWeatherInfo
    let pollutionInfo: PollutionInfo
}

/**
 Forecast Weather Info
 */
struct ForecastWeatherInfo: Codable {
    let list: [ForecastWeather]
    let city: City
}

/**
 Forecast Weather
 */
struct ForecastWeather: Codable, Identifiable {
    let id = UUID()
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
}

/**
 City
 */
struct City: Codable {
    let name: String
    let country: String
}

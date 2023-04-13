//
//  WeatherCodables.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

struct ForecastWeatherModel: Identifiable {
    let id = UUID()
    let currentWeatherInfo: CurrentWeatherInfo
    let forecastWeatherInfo: ForecastWeatherInfo
    let pollutionInfo: PollutionInfo
}

struct ForecastWeatherInfo: Codable {
    let list: [ForecastWeather]
    let city: City
}

struct ForecastWeather: Codable, Identifiable {
    let id = UUID()
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
}

struct City: Codable {
    let name: String
    let country: String
}

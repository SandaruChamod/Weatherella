//
//  CurrentWeather.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
    Current Weather Info
 */
struct CurrentWeatherInfo: Codable {
    let name: String
    let coord: Coordinates
    let weather: [Weather]
    let main: Main
    let clouds: Clouds
    let wind: Wind
    let dt: Double
    let sys: DayTimes
}

/**
    Day Times
 */
struct DayTimes: Codable {
    let sunrise: Int
    let sunset: Int
}

/**
    Coordinates
 */
struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

/**
    Main
 */
struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

/**
    Weather
 */
struct Weather: Codable {
    let id: Int
    let main: WeatherMain
    let description: WeatherDescription
    let icon: String
    
    var iconImageURL: URL? {
        let url = "https://openweathermap.org/img/wn/\(self.icon).png"
        return URL(string: url)
    }
}

/**
    Wind
 */
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

/**
    Clouds
 */
struct Clouds: Codable {
    let all: Int
}

/**
    Weather Main
 */
enum WeatherMain: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case snow = "Snow"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
}

/**
    Weather Description
 */
enum WeatherDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case thunderstormWithLightRain = "thunderstorm with light rain"
    case thunderstormWithRain = "thunderstorm with rain"
    case thunderstormWithHeavyRain = "thunderstorm with heavy rain"
    case lightThunderstorm = "light thunderstorm"
    case thunderstorm = "thunderstorm"
    case heavyThunderstorm = "heavy thunderstorm"
    case raggedThunderstorm = "ragged thunderstorm"
    case thunderstormWithLightDrizzle = "thunderstorm with light drizzle"
    case thunderstormWithDrizzle = "thunderstorm with drizzle"
    case thunderstormWithHeavyDrizzle = "thunderstorm with heavy drizzle"
    case heavyIntensityDrizzle = "heavy intensity drizzle"
    case lightIntensityDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyIntensityDrizzleRain = "heavy intensity drizzle rain"
    case showerRainAndDrizzle = "shower rain and drizzle"
    case heavyShowerRainAndDrizzle = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"
    case heavyIntensityRain = "heavy intensity rain"
    case veryHeavyRain = "very heavy rain"
    case extremeRain = "exteme rain"
    case freezingRain = "freezing rain"
    case lightIntensityShowerRain = "light intensity shower rain"
    case showerRain = "shower rain"
    case heavyIntensityShowerRain = "heavy intensity shower rain"
    case raggedShowerRain = "ragged shower rain"
    case lightSnow = "light snow"
    case Snow = "Snow"
    case HeavySnow = "Heavy snow"
    case Sleet = "Sleet"
    case LightShowerSleet = "Light shower sleet"
    case ShowerSleet = "Shower sleet"
    case LightRainAndSnow = "Light rain and snow"
    case RainAndSnow = "Rain and snow"
    case LightShowerSnow = "Light shower snow"
    case ShowerSnow = "Shower snow"
    case HeavyShowerSnow = "Heavy shower snow"
    case mist = "mist"
    case Smoke = "Smoke"
    case Haze = "Haze"
    case sandDustWhirls = "sand/dust whirls"
    case fog = "fog"
    case sand = "sand"
    case dust = "dXust"
    case volcanicAsh = "volcanic ash"
    case squalls = "squalls"
    case tornado = "tornado"
    case fewClouds1125 = "few clouds: 11-25%"
    case scatteredClouds2550 = "scattered clouds: 25-50%"
    case brokenClouds5184 = "broken clouds: 51-84%"
    case overcastClouds85100 = "overcast clouds: 85-100%"
}

//
//  WeatherDataModel.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

class AppWeatherData: ObservableObject {
    @Published var forecastInfo: ForecastWeatherModel?
    @Published var city = ""
    
    init() {
        forecastInfo = getWeatherFromJSONFile()
    }
    
    private func requestFromWeatherAPI<T: Decodable>(_ type: T.Type, for url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw fatalError("Given URL is invalid. Kindly check the URL")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let weatherData =  try JSONDecoder().decode(type, from: data)
            return weatherData
        } catch {
            throw error
        }
    }
    
    func loadFromJSONFile<T: Decodable>(_ type: T.Type, _ filename: String) -> T {
        let readData: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find the \(filename). Kindly check")
        }
        
        do {
            readData = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load the \(filename):\n\(error)")
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            let forecastData = try jsonDecoder.decode(type, from: readData)
            return forecastData
        } catch {
            fatalError("Couldn't parse the \(filename) for given type \(type):\n\(error)")
        }
    }
}

// MARK: JSON functions
extension AppWeatherData {
    func getWeatherFromJSONFile() -> ForecastWeatherModel {
        let currentWeatherData = loadFromJSONFile(CurrentWeatherInfo.self, "london-current-weather")
        let hourlySummaryData = loadFromJSONFile(ForecastWeatherInfo.self, "london-hourly-summary")
        let pollutionData = loadFromJSONFile(PollutionInfo.self, "london-air-pollution")
        return ForecastWeatherModel(currentWeatherInfo: currentWeatherData, forecastWeatherInfo: hourlySummaryData, pollutionInfo: pollutionData)
    }
}

// MARK: API functions
extension AppWeatherData {
    func getCityCurrentWeather() async throws  -> CurrentWeatherInfo {
        let cityValidated = urlEncodeString(stringValue: city)
        let urlInString = "\(WeatherAPI.current.url)&q=\(String(describing: cityValidated))"
        do {
            let currentWeatherData = try await requestFromWeatherAPI(CurrentWeatherInfo.self, for: urlInString)
            return currentWeatherData
        } catch {
            throw error
        }
    }
    
    func getCityForecastWeather() async throws  -> ForecastWeatherInfo {
        let cityValidated = urlEncodeString(stringValue: city)
        let urlInString = "\(WeatherAPI.forecast.url)&q=\(String(describing: cityValidated))"
        do {
            let forecastWeatherData = try await requestFromWeatherAPI(ForecastWeatherInfo.self, for: urlInString)
            return forecastWeatherData
        } catch {
            throw error
        }
    }
    
    func getForecstDataForCity() async throws {
        do {
            let cityCurrentWeather = try await getCityCurrentWeather()
            let cityForcastWhether = try await getCityForecastWeather()
            let cityLatitude = cityCurrentWeather.coord.lat
            let cityLongitude = cityCurrentWeather.coord.lon
            let pollutionData = try await getPollutionDataFromAPI(lat: cityLatitude, lon: cityLongitude)

            DispatchQueue.main.async {
                self.forecastInfo = ForecastWeatherModel(currentWeatherInfo: cityCurrentWeather, forecastWeatherInfo: cityForcastWhether, pollutionInfo: pollutionData)
            }
        } catch {
            throw error
        }
    }
    
    func getPollutionDataFromAPI(lat: Double, lon: Double) async throws -> PollutionInfo {
        let urlInString = "\(WeatherAPI.pollution.url)&lat=\(lat)&lon=\(lon)"
        do {
            let pollutionData = try await requestFromWeatherAPI(PollutionInfo.self, for: urlInString)
            return pollutionData
        } catch {
            throw error
        }
    }
}

extension AppWeatherData {
    func getFormattedPollutionData() -> [PollutionDataMap] {
        if let forecastInfo = self.forecastInfo, let pollutionComponents = forecastInfo.pollutionInfo.list.first?.components {
            let mappedList = [
                PollutionDataMap(image: "so2", value: pollutionComponents.so2),
                PollutionDataMap(image: "no", value: pollutionComponents.no2),
                PollutionDataMap(image: "voc", value: pollutionComponents.no),
                PollutionDataMap(image: "pm", value: pollutionComponents.pm10),
            ]
            return mappedList
        }
        return []
    }
}

struct PollutionDataMap {
    let id = UUID()
    let image: String
    let value: Double
}

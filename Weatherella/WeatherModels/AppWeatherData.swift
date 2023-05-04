//
//  WeatherDataModel.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 App Weather Data
 */
class AppWeatherData: ObservableObject {
    @Published var appData: ForecastWeatherModel?
    @Published var city = ""
    
    init() {
        // Load initial whether info from JSON file.
        appData = readAppDataFromJSONFile()
    }
    
    /**
     Responsible to fetch  weather data from weather API
     Param requestType : Data type
     Param urlString: URL string
     Returns weather data
     */
    private func fetchFromWeatherAPI<T: Decodable>(_ requestType: T.Type, for urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw fatalError("Given URL is invalid. Kindly check the URL")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let weatherData =  try JSONDecoder().decode(requestType, from: data)
            return weatherData
        } catch {
            throw error
        }
    }
    
    /**
     Responsible to load  weather data from JSON file
     Param requestType : Data type
     Param filenameString: File name
     Returns weather data
     */
    func loadFromJSONFile<T: Decodable>(_ requestType: T.Type, _ filenameString: String) -> T {
        let readData: Data
        
        guard let file = Bundle.main.url(forResource: filenameString, withExtension: "json")
        else {
            fatalError("Couldn't find the \(filenameString). Kindly check")
        }
        
        do {
            // Read data from the give file.
            readData = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load the \(filenameString):\n\(error)")
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            // Decode read data to an object.
            let forecastData = try jsonDecoder.decode(requestType, from: readData)
            return forecastData
        } catch {
            fatalError("Couldn't parse the \(filenameString) for given type \(requestType):\n\(error)")
        }
    }
}

extension AppWeatherData {
    /**
     Responsible to return all the weather data in initial load
     Returns ForecastWeatherModel
     */
    func readAppDataFromJSONFile() -> ForecastWeatherModel {
        let weatherData = loadFromJSONFile(Forecast.self, "london-weather")
        let pollutionData = loadFromJSONFile(PollutionInfo.self, "london-air-pollution")
        
        // Create and return weather model object.
        return ForecastWeatherModel(weatherInfo: weatherData, pollutionInfo: pollutionData)
    }
    
    /**
     Responsible to set all the weather  data for  the given city.
     */
    func getAppDataForCity(lat: Double, lon: Double) async throws {
        // Build weather url
        let weatherAPIUrl = "\(APIConfigs.weatherAPI.baseURL)&lat=\(lat)&lon=\(lon)"
        // Build pollution url
        let pollutionAPIUrl = "\(APIConfigs.pollutionAPI.baseURL)&lat=\(lat)&lon=\(lon)"
        
        do {
            // fetch weather data from API
            let weatherData = try await fetchFromWeatherAPI(Forecast.self, for: weatherAPIUrl)
            // fetch pollution data from API
            let pollutionData = try await fetchFromWeatherAPI(PollutionInfo.self, for: pollutionAPIUrl)
            
            DispatchQueue.main.async {
                // Create and set weather model object.
                self.appData = ForecastWeatherModel(weatherInfo: weatherData, pollutionInfo: pollutionData)
            }
        } catch {
            throw error
        }
    }
    
    /**
     Responsible to map all the pollution data to display.
     Returns [PollutionDataMap]
     */
    func getFormattedPollutionData() -> [PollutionDataMap] {
        if let forecastInfo = self.appData, let pollutionComponents = forecastInfo.pollutionInfo.list.first?.components {
            let mappedList = [
                PollutionDataMap(image: "so2", value: pollutionComponents.so2),
                PollutionDataMap(image: "no", value: pollutionComponents.no2),
                PollutionDataMap(image: "voc", value: pollutionComponents.o3),
                PollutionDataMap(image: "pm", value: pollutionComponents.pm10),
            ]
            return mappedList
        }
        return []
    }
}

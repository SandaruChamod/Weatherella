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
    @Published var forecastInfo: ForecastWeatherModel?
    @Published var city = ""
    
    init() {
        // Load initial whether info from JSON file.
        forecastInfo = getWeatherFromJSONFile()
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
    func getWeatherFromJSONFile() -> ForecastWeatherModel {
        let currentWeatherData = loadFromJSONFile(CurrentWeatherInfo.self, "london-current-weather")
        let hourlySummaryData = loadFromJSONFile(ForecastWeatherInfo.self, "london-hourly-summary")
        let pollutionData = loadFromJSONFile(PollutionInfo.self, "london-air-pollution")
        
        // Create and return weather model object.
        return ForecastWeatherModel(currentWeatherInfo: currentWeatherData, forecastWeatherInfo: hourlySummaryData, pollutionInfo: pollutionData)
    }
}

extension AppWeatherData {
    /**
        Responsible to return all the current weather info feched by the API call.
        Returns CurrentWeatherInfo
     */
    func getCityCurrentWeather() async throws  -> CurrentWeatherInfo {
        let cityValidated = urlEncodeString(stringValue: city)
        let urlInString = "\(APIConfigs.currentWeatherAPI.baseURL)&q=\(String(describing: cityValidated))"
        do {
            let currentWeatherData = try await fetchFromWeatherAPI(CurrentWeatherInfo.self, for: urlInString)
            return currentWeatherData
        } catch {
            throw error
        }
    }
    
    /**
        Responsible to return all the forecast  weather info feched by the API call.
        Returns ForecastWeatherInfo
     */
    func getCityForecastWeather() async throws  -> ForecastWeatherInfo {
        let cityValidated = urlEncodeString(stringValue: city)
        let urlInString = "\(APIConfigs.forecastWeatherAPI.baseURL)&q=\(String(describing: cityValidated))"
        do {
            let forecastWeatherData = try await fetchFromWeatherAPI(ForecastWeatherInfo.self, for: urlInString)
            return forecastWeatherData
        } catch {
            throw error
        }
    }
    
    /**
        Responsible to set all the weather  data for  the given city.
     */
    func getForecstDataForCity() async throws {
        do {
            let cityCurrentWeather = try await getCityCurrentWeather()
            let cityForcastWhether = try await getCityForecastWeather()
            let cityLatitude = cityCurrentWeather.coord.lat
            let cityLongitude = cityCurrentWeather.coord.lon
            let pollutionData = try await fetchPollutionDataFromAPI(lat: cityLatitude, lon: cityLongitude)

            DispatchQueue.main.async {
                // Create and set weather model object.
                self.forecastInfo = ForecastWeatherModel(currentWeatherInfo: cityCurrentWeather, forecastWeatherInfo: cityForcastWhether, pollutionInfo: pollutionData)
            }
        } catch {
            throw error
        }
    }
    
    /**
        Responsible to fetch all the pollution  data from API.
        Returns PollutionInfo
     */
    func fetchPollutionDataFromAPI(lat: Double, lon: Double) async throws -> PollutionInfo {
        let urlInString = "\(APIConfigs.pollutionAPI.baseURL)&lat=\(lat)&lon=\(lon)"
        do {
            let pollutionData = try await fetchFromWeatherAPI(PollutionInfo.self, for: urlInString)
            return pollutionData
        } catch {
            throw error
        }
    }
}

extension AppWeatherData {
    /**
        Responsible to map all the pollution data to display.
        Returns [PollutionDataMap]
     */
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

//
//  ViewModels.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import Foundation

/**
 Pollution Data Map
 */
struct PollutionDataMap {
    let id = UUID()
    let image: String
    let value: Double
}

/**
 Frame Option
 */
struct FrameOption {
    let width: Double
    let height: Double
}


/**
 Temperature Data Model
 */
struct TemperatureDataModel {
    let min_temp: Int
    let max_temp: Int
    let feelsLike: Int
}

/**
 Temperature Label  Model
 */
struct TemperatureLabelModel {
    let label: String
    let temp: Int
    let measurement: TempMeasurement
}

/**
 Temperature Measurement
 */
enum TempMeasurement : String {
    case celsius = "ºC"
    case fahrenheit = "ºF"
    case kelvin = "ºK"
}

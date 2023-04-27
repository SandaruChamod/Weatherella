//
//  ViewModels.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import Foundation

struct FrameOption {
    let width: Double
    let height: Double
}

struct TemperatureDataModel {
    let min_temp: Int
    let max_temp: Int
    let feelsLike: Int
}

struct TemperatureLabelModel {
    let label: String
    let temp: String
    let measurement: TempMeasurement
}

enum TempMeasurement : String {
    case celsius = "ºC"
    case fahrenheit = "ºF"
    case kelvin = "ºK"
}

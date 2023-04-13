//
//  Pollution.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

struct PollutionInfo: Codable {
    let list: [Pollution]
}

struct Pollution: Codable {
    let components: PollutionComponents
}

struct PollutionComponents: Codable {
    let so2: Double
    let no2: Double
    let no: Double
    let pm10: Double
}

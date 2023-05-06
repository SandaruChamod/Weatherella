//
//  PollutionInfo.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
 Pollution Info
 */
struct PollutionInfo: Codable {
    let list: [Pollution]
}

/**
 Pollution
 */
struct Pollution: Codable {
    let components: PollutionComponents
}

/**
 Pollution Components
 */
struct PollutionComponents: Codable {
    let so2: Double
    let no2: Double
    let no: Double
    let o3: Double
    let pm10: Double
}

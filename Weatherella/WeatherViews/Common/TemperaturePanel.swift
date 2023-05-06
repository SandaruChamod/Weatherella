//
//  TemperaturePanel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

/**
 Temperature Panel
 */
struct TemperaturePanel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let temp = appWeatherData.appData?.weatherInfo.daily.first?.temp
        let min: Int = temp?.min.toInt() ?? 0
        let max: Int = temp?.max.toInt() ?? 0
        let feelsLike: Int = temp?.day.toInt() ?? 0
        
        VStack (spacing: 30) {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "arrow.up")
                        .symbolRenderingMode(.multicolor)
                    Text("High \(max)\(TempMeasurement.celsius.rawValue)")
                }
                Spacer()
                HStack {
                    Image(systemName: "arrow.down")
                        .symbolRenderingMode(.multicolor)
                    Text("Low \(min)\(TempMeasurement.celsius.rawValue)")
                }
                Spacer()
            }
            
            HStack {
                Image(systemName: "face.smiling")
                    .symbolRenderingMode(.multicolor)
                Text("Feels Like \(feelsLike)ºC")
            }
        }
    }
}

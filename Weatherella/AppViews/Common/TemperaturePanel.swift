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
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        let min: Int = Int(current?.main.temp_min ?? 0)
        let max: Int = Int((current?.main.temp_max ?? 0))
        let feelsLike: Int = Int(current?.main.temp ?? 0)

        VStack (spacing: 30) {
            HStack {
                Spacer()
                TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "H:", temp: min, measurement: .celsius))
                Spacer()
                TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Low:", temp: max, measurement: .celsius))
                Spacer()
            }
            
            Text("Feels Like: \(feelsLike)ºC")
        }
    }
}

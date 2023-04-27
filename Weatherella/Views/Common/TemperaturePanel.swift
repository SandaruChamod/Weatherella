//
//  TemperaturePanel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

struct TemperaturePanel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        let min: String = Double((current?.main.temp_min ?? 0)).convertToSingleDecimal()
        let max: String = Double((current?.main.temp_max ?? 0)).convertToSingleDecimal()
        let feelsLike: String = Double((current?.main.temp ?? 0)).convertToSingleDecimal()

        HStack {
            Spacer()
            TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "H:", temp: min, measurement: .celsius))
            Spacer()
            TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Low:", temp: max, measurement: .celsius))
            Spacer()
        }

        Text("Feels Like: \(feelsLike)ºC")
            .foregroundColor(.black)
    }
}

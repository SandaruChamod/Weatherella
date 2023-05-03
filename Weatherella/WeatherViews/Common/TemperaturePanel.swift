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
        let current  = appWeatherData.appData?.weatherInfo.current
        let min: Int = Int(current?.dewPoint ?? 0)
        let max: Int = Int((current?.temp ?? 0))
        let feelsLike: Int = Int(current?.feelsLike ?? 0)
        
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

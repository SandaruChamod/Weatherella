//
//  TemperatureLabel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

/**
 Temperature Label
 */
struct CurrentTemperatureLabel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    @State var tempLabelModel: TemperatureLabelModel
    
    var body: some View {
        let current  = appWeatherData.appData?.weatherInfo.current

        Text("\(tempLabelModel.label) \(current?.temp.toInt() ?? 0)\(tempLabelModel.measurement.rawValue)")
    }
}

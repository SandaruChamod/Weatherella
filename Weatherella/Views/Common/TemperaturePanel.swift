//
//  TemperaturePanel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

struct TemperaturePanel: View {
    @State var tempData: TemperatureDataModel
    
    var body: some View {
        let min: String = tempData.min_temp.convertToSingleDecimal()
        let max: String = tempData.max_temp.convertToSingleDecimal()

        HStack {
            Spacer()
            TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "H:", temp: min, measurement: .celsius))
            Spacer()
            TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Low:", temp: max, measurement: .celsius))
            Spacer()
        }

        Text("Feels Like: \((tempData.feelsLike))ºC")
            .foregroundColor(.black)
    }
}

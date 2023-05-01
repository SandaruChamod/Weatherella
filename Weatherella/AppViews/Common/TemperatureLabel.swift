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
struct TemperatureLabel: View {
    @State var tempLabelModel: TemperatureLabelModel
    
    var body: some View {
        Text("\(tempLabelModel.label) \((tempLabelModel.temp))ºC")
    }
}

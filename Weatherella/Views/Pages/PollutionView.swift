//
//  PollutionView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject private var appWeatherData: AppWeatherData

    var body: some View {
        
        let formattedPollutionData = appWeatherData.getFormattedPollutionData()
        
        VStack {
            HStack {
                ForEach(formattedPollutionData, id: \.self.id) { pollutionData in
                    VStack {
                        Image(pollutionData.image)
                        Text("\(pollutionData.value.convertToSingleDecimal())")
                    }
                }
            }
        }
    }
}



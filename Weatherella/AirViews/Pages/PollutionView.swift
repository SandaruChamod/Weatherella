//
//  PollutionView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Pollution View
 */
struct PollutionView: View {
    
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let formattedPollutionData = appWeatherData.getFormattedPollutionData()
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack (spacing: 30) {
                LocationPanel()
                
                CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "", measurement: .celsius))
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                
                TemperaturePanel()
                    .shadow(color: .black, radius: 0.5)
                
                HStack {
                    Spacer()
                    Text("Air Quality Data:")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack {
                    ForEach(formattedPollutionData, id: \.self.id) { pollutionData in
                        VStack {
                            Image(pollutionData.image)
                            Text("\(pollutionData.value.convertToTwoDecimals())")
                        }
                    }
                }
            }
        }
    }
}



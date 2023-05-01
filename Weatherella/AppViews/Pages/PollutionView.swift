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
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack (spacing: 30) {
                LocationPanel()
                
                Text("\(current?.main.temp.convertToSingleDecimal() ?? "")ºC")
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                WeatherStatusPanel(frameOptions: FrameOption(width: 60, height: 60))
                
                TemperaturePanel()
                
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
                            Text("\(pollutionData.value.convertToSingleDecimal())")
                        }
                    }
                }
            }
        }
    }
}



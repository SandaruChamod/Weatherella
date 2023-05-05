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
            
            VStack (spacing: 10) {
                VStack (spacing: 20) {
                    AppHeader()
                    Text("Less air pollution is the answer to a healthy life solution.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .padding(.top, -10)
                .padding(.bottom, 10)

                VStack (spacing: 10) {
                    LocationPanel()
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: .black, radius: 0.1)
                    
                    HStack {
                        Spacer()
                        CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "", measurement: .celsius))
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("theme").opacity(0.8))
                            )
                        Spacer()
                        WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    TemperaturePanel()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black.opacity(0.3))
                        .padding(.horizontal)
                )
                
                VStack {
                    HStack {
                        Text("Air Quality Data")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    
                    HStack {
                        ForEach(formattedPollutionData, id: \.self.id) { pollutionData in
                            VStack {
                                Image(pollutionData.image)
                                Text("\(pollutionData.value.convertToTwoDecimals())")
                                    .foregroundColor(.black.opacity(0.8))
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white.opacity(0.6))
                        .padding(.horizontal)
                )
            }
        }
    }
}



//
//  CurrentWeatherView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Current Weather View
 */
struct CurrentWeatherView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let current  = appWeatherData.appData?.weatherInfo.current
        
        ScrollView {
            ZStack {
                Image("background2")
                    .resizable()
                    .ignoresSafeArea(.container)
                
                VStack (spacing: 30) {
                    VStack (spacing: 50) {
                        LocationPanel()
                        
                        MainTemperatureLabel()
                        
                        WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                        
                        TemperaturePanel()
                            .shadow(color: .black, radius: 0.5)
                    }
                    .padding(.top, 100)
                    
                    VStack (spacing: 50) {
                        HStack {
                            Text("Wind Speed: \(current?.windSpeed.toInt() ?? 0)m/s")
                                .shadow(color: .black, radius: 0.5)
                            Spacer()
                            Text("Direction: \(convertDegToCardinal(deg: current?.windDeg ?? 0))")
                                .shadow(color: .black, radius: 0.5)
                        }.padding(.horizontal)
                        
                        HStack {
                            Text("Humidity: \(current?.humidity ?? 0)%")
                                .shadow(color: .black, radius: 0.5)
                            Spacer()
                            Text("Presure: \(current?.pressure ?? 0) hPg")
                                .shadow(color: .black, radius: 0.5)
                        }.padding(.horizontal)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            HStack {
                                Image(systemName: "sunset.fill")
                                    .symbolRenderingMode(.multicolor)
                                Text(Date(timeIntervalSince1970: TimeInterval(current?.sunset ?? 0))
                                    .formatted(.dateTime.hour().minute().attributed))
                                .shadow(color: .black, radius: 0.5)
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "sunset.fill")
                                    .symbolRenderingMode(.multicolor)
                                Text(Date(timeIntervalSince1970: TimeInterval(current?.sunrise ?? 0))
                                    .formatted(.dateTime.hour().minute().attributed))
                                .shadow(color: .black, radius: 0.5)
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 150)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

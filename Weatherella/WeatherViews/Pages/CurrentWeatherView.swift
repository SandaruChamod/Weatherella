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
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        
        ZStack {
            Image("background2")
                .resizable()
            VStack (spacing: 40) {
                LocationPanel()
                
                MainTemperatureLabel()
                
                WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                
                TemperaturePanel()
                    .shadow(color: .black, radius: 0.5)

                VStack (spacing: 50) {
                    HStack {
                        Text("Wind Speed: \((Int)(current?.wind.speed ?? 0))m/s")
                            .shadow(color: .black, radius: 0.5)
                        Spacer()
                        Text("Direction: \(convertDegToCardinal(deg: current?.wind.deg ?? 0))")
                            .shadow(color: .black, radius: 0.5)
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Humidity: \((Int)(current?.main.humidity ?? 0))%")
                            .shadow(color: .black, radius: 0.5)
                        Spacer()
                        Text("Presure: \((Int)(current?.main.pressure ?? 0)) hPg")
                            .shadow(color: .black, radius: 0.5)
                    }.padding(.horizontal)
                }
                
                VStack {
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: "sunset.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current?.sys.sunset ?? 0))))
                                .formatted(.dateTime.hour().minute().attributed))
                                .shadow(color: .black, radius: 0.5)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "sunset.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current?.sys.sunrise ?? 0))))
                                .formatted(.dateTime.hour().minute().attributed))
                            .shadow(color: .black, radius: 0.5)
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

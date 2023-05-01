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
                    .bold()
                
                VStack (spacing: 50) {
                    HStack {
                        Text("Wind Speed: \((Int)(current?.wind.speed ?? 0))m/s")
                            .bold()
                        Spacer()
                        Text("Direction: \(convertDegToCardinal(deg: current?.wind.deg ?? 0))")
                            .bold()
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Humidity: \((Int)(current?.main.humidity ?? 0))%")
                            .bold()
                        Spacer()
                        Text("Presure: \((Int)(current?.main.pressure ?? 0))hPg")
                            .bold()
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
                            .bold()
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "sunset.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current?.sys.sunrise ?? 0))))
                                .formatted(.dateTime.hour().minute().attributed))
                            .bold()
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

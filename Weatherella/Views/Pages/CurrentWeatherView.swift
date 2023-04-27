//
//  CurrentWeatherView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData

    var body: some View {
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        
        ZStack {
            Image("background2")
                .resizable()
            VStack (spacing: 30) {
                LocationPanel()
                                
                Text("\(current?.main.temp.convertToSingleDecimal() ?? "")ºC")
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                WeatherStatusPanel(frameOptions: FrameOption(width: 60, height: 60))
                
                TemperaturePanel()
                
                VStack (spacing: 30) {
                    HStack {
                        Text("Wind Speed: \((Int)(current?.wind.speed ?? 0))m/s")
                        Spacer()
                        Text("Direction: \(convertDegToCardinal(deg: current?.wind.deg ?? 0))")
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Humidity: \((Int)(current?.main.humidity ?? 0))%")
                        Spacer()
                        Text("Humidity: \((Int)(current?.main.pressure ?? 0))hPg")
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
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "sunset.fill")
                                .symbolRenderingMode(.multicolor)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current?.sys.sunrise ?? 0))))
                                .formatted(.dateTime.hour().minute().attributed))
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        }
}

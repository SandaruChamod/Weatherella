//
//  HourlySummaryView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
    Hourly View
 */
struct HourlyView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let forecast = appWeatherData.forecastInfo?.forecastWeatherInfo
        let forecastList = forecast?.list
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                LocationPanel()
                
                List(forecastList ?? []) { forecast in
                    HStack {
                        Spacer()
                        VStack (spacing: 0) {
                            Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).attributed))")
                            Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(.dateTime.weekday(.abbreviated)))")
                        }
                        Spacer()
                        AsyncImage(url: forecast.weather.first?.iconImageURL) {
                            image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text("\(forecast.main.temp.convertToSingleDecimal())ºC")
                        Spacer()
                        Text("\(forecast.weather.first?.main.rawValue ?? "")")
                        Spacer()
                    }
                }
                .opacity(0.8)
            }
        }
    }
}

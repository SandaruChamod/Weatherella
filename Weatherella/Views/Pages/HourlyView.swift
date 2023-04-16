//
//  HourlySummaryView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct HourlyView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let forecast = appWeatherData.forecastInfo
        let forecastList = forecast?.forecastWeatherInfo.list
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                Text("\(forecast?.forecastWeatherInfo.city.name ?? ""), \(forecast?.forecastWeatherInfo.city.country ?? "")")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
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

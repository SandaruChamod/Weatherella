//
//  ForecastView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData

    var body: some View {
        let forecast = appWeatherData.forecastInfo
        let forecastList = forecast?.forecastWeatherInfo.list
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Text("\(forecast?.forecastWeatherInfo.city.name ?? ""), \(forecast?.forecastWeatherInfo.city.country ?? "")")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                List(forecastList ?? []) { forecast in
                    HStack (spacing: 10) {
                        Spacer()
                        AsyncImage(url: forecast.weather.first?.iconImageURL) {
                            image in
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack {
                            Text("\(forecast.weather.first?.main.rawValue ?? "")")
                            HStack (spacing: 5) {
                                Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(Date.FormatStyle().weekday(.wide)))")
                                Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(Date.FormatStyle().weekday(.twoDigits)))")
                            }
                        }
                        Text("\(forecast.main.temp_min.convertToSingleDecimal())ºC / \(forecast.main.temp_max.convertToSingleDecimal())ºC")
                        Spacer()
                    }
                }
                .opacity(0.8)
            }
        }
    }
}

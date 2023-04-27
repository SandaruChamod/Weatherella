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
        let forecast = appWeatherData.forecastInfo?.forecastWeatherInfo
        let forecastList = forecast?.list
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                LocationPanel(content: "\(forecast?.city.name ?? ""), \(forecast?.city.country ?? "")")
                
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

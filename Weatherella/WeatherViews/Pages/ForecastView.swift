//
//  ForecastView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Forecast View
 */
struct ForecastView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let forecastList = appWeatherData.appData?.weatherInfo.daily ?? []
        
        ZStack {
            Image("background2")
                .resizable()
            
            VStack {
                LocationPanel()
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                    .shadow(color: .black, radius: 0.1)
                
                VStack {
                    List {
                        ForEach(forecastList, id: \.self.id) { forecast in
                            HStack (spacing: 5) {
                                AsyncImage(url: forecast.weather.first?.iconImageURL) {
                                    image in
                                    image
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                } placeholder: {
                                    ProgressView()
                                }
                                Spacer()
                                VStack {
                                    Text("\(forecast.weather.first?.main.rawValue ?? "")")
                                    HStack (spacing: 3) {
                                        Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(Date.FormatStyle().weekday(.wide)))")
                                        Text("\(forecast.dt.getDateFromUTCTimestamp().formatted(Date.FormatStyle().weekday(.twoDigits)))")
                                    }
                                }
                                Spacer()
                                Text("\(Int(forecast.temp.min ))ºC / \(Int(forecast.temp.max))ºC")
                            }
                        }
                    }
                }
                .opacity(0.8)
            }
            .padding(.top, 70)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

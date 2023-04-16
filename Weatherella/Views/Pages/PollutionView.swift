//
//  PollutionView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject private var appWeatherData: AppWeatherData

    var body: some View {
        
        let formattedPollutionData = appWeatherData.getFormattedPollutionData()
        let forecast = appWeatherData.forecastInfo
        let current  = forecast?.currentWeatherInfo
        let currentDate = current?.dt.getDateFromUTCTimestamp() ?? Date()
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack (spacing: 30) {
                Text("\(forecast?.forecastWeatherInfo.city.name ?? ""), \(forecast?.forecastWeatherInfo.city.country ?? "")")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text("\(current?.main.temp.convertToSingleDecimal() ?? "")ºC")
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack {
                    AsyncImage(url: current?.weather.first?.iconImageURL) {
                        image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(current?.weather[0].main.rawValue ?? "")
                }
                
                HStack {
                    Spacer()
                    Text("H: \((Int)(current?.main.temp_min ?? 0))ºC")
                    Spacer()
                    Text("Low: \((Int)(current?.main.temp_max ?? 0))ºC")
                    Spacer()
                }

                Text("Feels Like: \((Int)(current?.main.temp ?? 0))ºC")
                    .foregroundColor(.black)
                
                HStack {
                    Spacer()
                    Text("Air Quality Data:")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                HStack {
                    ForEach(formattedPollutionData, id: \.self.id) { pollutionData in
                        VStack {
                            Image(pollutionData.image)
                            Text("\(pollutionData.value.convertToSingleDecimal())")
                        }
                    }
                }
            }
        }
    }
}



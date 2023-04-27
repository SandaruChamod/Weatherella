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
        let forecast = appWeatherData.forecastInfo?.forecastWeatherInfo
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack (spacing: 30) {
                LocationPanel(content: "\(forecast?.city.name ?? ""), \(forecast?.city.country ?? "")")
                
                Text("\(current?.main.temp.convertToSingleDecimal() ?? "")ºC")
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                WeatherStatusPanel(statusViewModel: StatusViewModel(label: current?.weather.first?.main.rawValue ?? "", imageUrl: (current?.weather.first?.iconImageURL ?? URL(string: ""))!, frameOptions: FrameOption(width: 60, height: 60)))
                
                TemperaturePanel(tempData: TemperatureDataModel(min_temp: Int(current?.main.temp_min ?? 0), max_temp: Int(current?.main.temp_max ?? 0), feelsLike: Int(current?.main.temp ?? 0)))
                
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



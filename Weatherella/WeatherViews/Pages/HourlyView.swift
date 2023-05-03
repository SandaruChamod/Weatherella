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
        let hourlyList = appWeatherData.appData?.weatherInfo.hourly ?? []
        
        ZStack {
            Image("background")
                .resizable()
            
            VStack {
                LocationPanel()
                List {
                    ForEach(hourlyList) { summary in
                        HStack {
                            VStack (spacing: 0) {
                                Text("\((Date(timeIntervalSince1970: TimeInterval(summary.dt)).formatted(.dateTime.hour(.twoDigits(amPM: .wide)))))")
                                Text("\((Date(timeIntervalSince1970: TimeInterval(summary.dt)).formatted(.dateTime.weekday())))")
                            }
                            Spacer()
                            AsyncImage(url: summary.weather.first?.iconImageURL) {
                                image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "", temp: summary.temp.toInt(), measurement: .celsius))
                            Spacer()
                            Text("\(summary.weather.first?.main.rawValue ?? "")")
                                .listRowSeparatorTint(.red)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .opacity(0.8)
            }
            .padding(.top, 70)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

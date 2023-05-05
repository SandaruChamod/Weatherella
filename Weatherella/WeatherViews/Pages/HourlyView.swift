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
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .fixedSize(horizontal: false, vertical: true)
                    .shadow(color: .black, radius: 0.1)
                List {
                    ForEach(hourlyList, id: \.self.id) { summary in
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
                            CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "", measurement: .celsius))
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

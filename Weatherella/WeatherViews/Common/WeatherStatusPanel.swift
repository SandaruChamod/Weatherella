//
//  WeatherStatusView.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

/**
 Weather Status Panel
 */
struct WeatherStatusPanel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    @State var frameOptions: FrameOption
    
    var body: some View {
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        HStack {
            AsyncImage(url: (current?.weather.first?.iconImageURL ?? URL(string: ""))!) {
                image in
                image
                    .resizable()
                    .frame(width: frameOptions.width, height: frameOptions.height)
            } placeholder: {
                ProgressView()
            }
            Text(current?.weather.first?.main.rawValue ?? "")
                .shadow(color: .black, radius: 0.5)
        }
    }
}


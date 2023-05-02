//
//  LocationPanel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

/**
 Location Panel
 */
struct LocationPanel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let forecast = appWeatherData.forecastInfo?.forecastWeatherInfo
        Text("\(forecast?.city.name ?? ""), \(forecast?.city.country ?? "")")
            .font(.title)
            .foregroundColor(.black)
            .shadow(color: .black, radius: 0.5)
            .multilineTextAlignment(.center)
    }
}


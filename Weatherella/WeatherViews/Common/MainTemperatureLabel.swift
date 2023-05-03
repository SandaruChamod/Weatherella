//
//  MainTemperatureLabel.swift
//  Weatherella
//
//  Created by user234080 on 5/1/23.
//

import SwiftUI

/**
 Main Temperature Label
 */
struct MainTemperatureLabel: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let current  = appWeatherData.appData?.weatherInfo.current
        
        Text("\(Int(current?.temp ?? 0))ºC")
            .font(.system(size: 30))
            .foregroundColor(.black)
            .shadow(color: .black, radius: 0.5)
    }
}

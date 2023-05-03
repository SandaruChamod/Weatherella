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
        Text("\(appWeatherData.city)")
            .font(.title)
            .foregroundColor(.black)
            .shadow(color: .black, radius: 0.5)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 3)
    }
}


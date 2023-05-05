//
//  AppHeader.swift
//  Weatherella
//
//  Created by user234080 on 5/5/23.
//

import SwiftUI

/**
 App Header
 */
struct AppHeader: View {
    var body: some View {
        HStack {
            Image("weather")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
            Text("Weatherella™")
                .tracking(5)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .font(.system(.largeTitle, design: .rounded))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}


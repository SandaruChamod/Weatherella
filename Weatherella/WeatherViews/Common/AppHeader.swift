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
        HStack (spacing: 0) {
            Image("weather")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 40)
            Text("Weatherella")
                .tracking(3)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .font(.system(size: 20, design: .rounded))
                .fixedSize(horizontal: false, vertical: true)
            Text("™")
                .tracking(3)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .font(.system(size: 20, design: .rounded))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 90)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.9))
                .padding(.horizontal)
        )
    }
}


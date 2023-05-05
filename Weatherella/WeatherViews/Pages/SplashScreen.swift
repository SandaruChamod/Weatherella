//
//  SplashScreen.swift
//  Weatherella
//
//  Created by user234080 on 5/5/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    @State private var scale = 1.0
    @State private var value = 0.0
    
    var body: some View {
        ZStack {
            Color(red: 0.9529, green: 0.9686, blue: 0.9843)
            if self.isActive {
                WeatherellaTabView()
            } else {
                VStack(spacing: 0) {
                    ZStack {
                        Image("weather")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                    }
                    VStack (spacing: 10) {
                        Text("Weatherella™")
                            .tracking(5)
                            .foregroundColor(.gray)
                            .font(.system(.largeTitle, design: .rounded))
                        ProgressView("", value: value, total: 100)
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaleEffect(2)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("theme")))
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    self.value += 50
                                }
                            }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                    scale += 1
                }
            }
        }
    }
}


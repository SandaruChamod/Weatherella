//
//  CurrentWeatherView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Current Weather View
 */
struct CurrentWeatherView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    var body: some View {
        let current  = appWeatherData.appData?.weatherInfo.current
        
        ScrollView {
            ZStack {
                Image("background2")
                    .resizable()
                    .ignoresSafeArea(.container)
                
                VStack (spacing: 10) {
                    Spacer(minLength: 90)
                    VStack {
                        AppHeader()
                        Text("The bad news is time flies. The good news is you're the pilot.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 5)
                    
                    VStack {
                        LocationPanel()
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                    }
                    .padding(.vertical)
                    
                    VStack (spacing: 10) {
                        VStack {
                            HStack {
                                Spacer()
                                CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "", measurement: .celsius))
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("theme").opacity(0.8))
                                    )
                                Spacer()
                                WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                                    .foregroundColor(.white.opacity(0.8))
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            VStack {
                                HStack {
                                    Spacer()
                                    HStack {
                                        Image(systemName: "sunset.fill")
                                            .symbolRenderingMode(.multicolor)
                                        Text(Date(timeIntervalSince1970: TimeInterval(current?.sunset ?? 0))
                                            .formatted(.dateTime.hour().minute().attributed))
                                        .foregroundColor(.white)
                                    }
                                    Spacer()
                                    HStack {
                                        Image(systemName: "sunset.fill")
                                            .symbolRenderingMode(.multicolor)
                                        Text(Date(timeIntervalSince1970: TimeInterval(current?.sunrise ?? 0))
                                            .formatted(.dateTime.hour().minute().attributed))
                                        .foregroundColor(.white)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black.opacity(0.3))
                            .padding(.horizontal)
                    )
                    
                    VStack (spacing: 20) {
                        TemperaturePanel()
                            .foregroundColor(.black.opacity(0.8))
                        
                        HStack {
                            IconLabel(icon: "speedometer", label: "Wind Speed: \(current?.windSpeed.toInt() ?? 0)m/s")
                                .foregroundColor(.black.opacity(0.8))
                            Spacer()
                            IconLabel(icon: "arrow.left.arrow.right.circle", label: "Direction: \(convertDegToCardinal(deg: current?.windDeg ?? 0))")
                                .foregroundColor(.black.opacity(0.8))
                        }.padding(.horizontal)
                        
                        HStack {
                            IconLabel(icon: "drop.circle", label: "Humidity: \(current?.humidity ?? 0)%")
                                .foregroundColor(.black.opacity(0.8))
                            Spacer()
                            IconLabel(icon: "arrow.down.forward.and.arrow.up.backward.circle", label: "Presure: \(current?.pressure ?? 0) hPg")
                                .foregroundColor(.black.opacity(0.8))
                        }.padding(.horizontal)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.5))
                            .padding(.horizontal)
                    )
                    
                    Spacer(minLength: 30)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//
//  CityWeatherView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Home View
 */
struct HomeView: View {
    @EnvironmentObject private var appWeatherData: AppWeatherData
    @State var showSearchView: Bool = false
    @State  var userLocationData: String = ""
    
    @State private var isLocationChanging = false
    @State var showErrorMessage = false
    @State var errorMessage = "Couldn't find the location"
    
    var body: some View {
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        let currentDate = current?.dt.getDateFromUTCTimestamp() ?? Date()
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack (spacing: 30) {
                HStack {
                    Spacer()
                    Button {
                        self.isLocationChanging.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                    }
                    .padding()
                    Spacer()
                }.padding(.vertical, 100)
                
                VStack (spacing: 10) {
                    LocationPanel()
                    
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current?.dt ?? 0))))
                        .formatted(.dateTime.year().hour().month().day()))
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 1)
                }
                
                Spacer()
                
                TemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Temp:", temp: Int(current?.main.temp ?? 0), measurement: .celsius))
                    .font(.title2)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity:  \(current?.main.humidity ?? 0)%")
                    .font(.title2)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure:  \(current?.main.pressure ?? 0) hPa")
                    .font(.title2)
                    .shadow(color: .black, radius: 0.5)
                
                WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                
                Spacer()
            }
            .onAppear {
                Task.init {
                    self.userLocationData = ""
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isLocationChanging) {
            CountrySearchSheet(showErrorMessage: $showErrorMessage, errorMessage: $errorMessage)
        }
        .alert(errorMessage, isPresented: $showErrorMessage) {
            Label("Search", systemImage: "star")
        }
    }
}

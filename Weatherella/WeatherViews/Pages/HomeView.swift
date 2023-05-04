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
    @State  var userLocation: String = ""
    
    var body: some View {
        let weatherInfo  = appWeatherData.appData?.weatherInfo
        let current  = weatherInfo?.current
        
        ScrollView {
            ZStack {
                Image("background2")
                    .resizable()
                    .ignoresSafeArea(.container)
                
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
                    }.padding(.vertical, 80)
                    
                    VStack (spacing: 10) {
                        LocationPanel()
                        
                        Text(Date(timeIntervalSince1970: TimeInterval(current?.dt ?? 0))
                            .formatted(.dateTime.year().hour().month().day()))
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    }
                    
                    Spacer()
                    
                    CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Temp:", measurement: .celsius))
                        .font(.title2)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Humidity:  \(current?.humidity ?? 0)%")
                        .font(.title2)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Pressure:  \(current?.pressure ?? 0) hPa")
                        .font(.title2)
                        .shadow(color: .black, radius: 0.5)
                    
                    Spacer()
                    
                    WeatherStatusPanel(frameOptions: FrameOption(width: 80, height: 80))
                    
                    Spacer()
                }
                .onAppear {
                    Task.init {
                        self.userLocation = await getLocFromLatLong(lat: (weatherInfo!.lat), lon: (weatherInfo!.lon))
                        self.appWeatherData.city = userLocation
                    }
                }
            }
            .sheet(isPresented: $isLocationChanging) {
                CountrySearchSheet(showErrorMessage: $showErrorMessage, errorMessage: $errorMessage)
            }
            .alert(errorMessage, isPresented: $showErrorMessage) {
                Label("Search", systemImage: "star")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

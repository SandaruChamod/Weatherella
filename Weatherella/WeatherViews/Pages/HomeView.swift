//
//  HomeView.swift
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
                
                VStack (spacing: 40) {
                    VStack (spacing: 10) {
                        AppHeader()
                        Spacer()
                        Text("Wherever you go, no matter what the weather, always bring your own sunshine.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 90)

                    HStack {
                        Spacer()
                        Button {
                            self.isLocationChanging.toggle()
                        } label: {
                            Label("Change Location", systemImage: "magnifyingglass")
                        }
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(30)
                        Spacer()
                    }
                    
                    VStack (spacing: 20) {
                        LocationPanel()
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        
                        Text(Date(timeIntervalSince1970: TimeInterval(current?.dt ?? 0))
                            .formatted(.dateTime.year().hour().month().day()))
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 30))
                        .shadow(color: .black, radius: 0.1)
                    }
                    
                    VStack (spacing: 10) {
                        HStack {
                            VStack {
                                WeatherStatusPanel(frameOptions: FrameOption(width: 60, height: 60))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("theme").opacity(0.5))
                                    )
                            }
                            .padding()
                            VStack (alignment: .leading, spacing: 30){
                                HStack {
                                    Image(systemName: "thermometer.sun.circle")
                                        .symbolRenderingMode(.multicolor)
                                    CurrentTemperatureLabel(tempLabelModel: TemperatureLabelModel(label: "Temperature ", measurement: .celsius))
                                        .font(.title2)
                                        .foregroundColor(.black.opacity(0.8))
                                }
                                
                                IconLabel(icon: "drop.circle", label: "Humidity \(current?.humidity ?? 0)%")
                                    .foregroundColor(.black.opacity(0.8))
                                    .font(.title2)
                                
                                IconLabel(icon: "arrow.down.forward.and.arrow.up.backward.circle", label: "Pressure \(current?.pressure ?? 0) hPa ")
                                    .foregroundColor(.black.opacity(0.8))
                                    .font(.title2)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.5))
                            .padding(.horizontal)
                    )
                    
                    Spacer(minLength: 15)
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

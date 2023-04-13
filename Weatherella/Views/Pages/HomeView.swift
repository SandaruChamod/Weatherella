//
//  CityWeatherView.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var appWeatherData: AppWeatherData
    @State var showSearchView: Bool = false
    @State  var userLocationData: String = ""
    
    @State private var isLocationChanging = false
    @State var showErrorMessage = false
    @State var errorMessage = "Couldn't find the location"
    
    var body: some View {
        let forecast = appWeatherData.forecastInfo
        let current  = appWeatherData.forecastInfo?.currentWeatherInfo
        let currentDate = forecast?.currentWeatherInfo.dt.getDateFromUTCTimestamp() ?? Date()
        
        ZStack {
            Image("background2")
                .resizable()
            VStack {
                Spacer()
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
                }
                
                Text("\(forecast?.forecastWeatherInfo.city.name ?? ""), \(forecast?.forecastWeatherInfo.city.country ?? "")")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text("\(currentDate.formatted(date: .abbreviated, time: .shortened))")
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \(current?.main.temp.convertToSingleDecimal() ?? "")ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity:  \(current?.main.humidity ?? 0)%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure:  \(current?.main.pressure ?? 0)")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack {
                    Text("field")
    //                AsyncImage(url: URL(string: "https://openweathermap.org/img/w/\(weatherDataModel.forecast?.current.weather[0].icon ?? "").png"))
                }
                
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

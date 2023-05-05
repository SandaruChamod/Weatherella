//
//  CountryInputSheet.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI
import CoreLocation

/**
 Country Search View
 */
struct CountrySearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    @Binding var showErrorMessage: Bool
    @Binding var errorMessage: String
    @State var cityInput: String = ""
    
    var body: some View {
        ZStack {
            Color("theme").edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Input City", text: $cityInput, onCommit: onCityInputCommit)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                    .tint(.black)
                    .buttonStyle(.bordered)
            }
        }
    }
    
    /**
     Responsible to trigger on city input commit event.
     */
    func onCityInputCommit() -> Void {
        CLGeocoder().geocodeAddressString(cityInput) { (placemarks, error) in
            // Show error when the given city value is incorrect
            guard error == nil else {
                showErrorMessage.toggle()
                return
            }
            
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                Task {
                    let _ = try await appWeatherData.getAppDataForCity(lat: lat, lon: lon)
                    appWeatherData.city = await getLocFromLatLong(lat: lat, lon: lon)
                }
            }
        }
        dismiss()
    }
}


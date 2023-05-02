//
//  CountryInputSheet.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

/**
 Country Search View
 */
struct CountrySearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    @Binding var showErrorMessage: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Input City", text: $appWeatherData.city, onCommit: onCityInputCommit)
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
        Task {
            do {
                try await appWeatherData.getForecstDataForCity()
            } catch {
                print("Search error: \(error.localizedDescription)")
                showErrorMessage.toggle()
            }
        }
        dismiss()
    }
}


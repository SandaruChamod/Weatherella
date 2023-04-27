//
//  CountryInputSheet.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import SwiftUI

struct CountrySearchSheet: View {
    @State var cityTextInput: String =  ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appWeatherData: AppWeatherData
    
    @Binding var showErrorMessage: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                TextField("City", text: $appWeatherData.city)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                Button {
                    Task {
                        do {
                            try await appWeatherData.getForecstDataForCity()
                        } catch {
                            print("Search error: \(error.localizedDescription)")
                            showErrorMessage.toggle()
                        }
                    }
                    dismiss()
                } label: {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tint(.black)
                .buttonStyle(.bordered)
            }
        }
        
    }
}


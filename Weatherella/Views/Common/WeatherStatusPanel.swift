//
//  WeatherStatusView.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

struct WeatherStatusPanel: View {
    @State var statusViewModel: StatusViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: statusViewModel.imageUrl) {
                image in
                image
                    .resizable()
                    .frame(width: statusViewModel.frameOptions.width, height: statusViewModel.frameOptions.height)
            } placeholder: {
                ProgressView()
            }
            Text(statusViewModel.label)
        }
    }
}


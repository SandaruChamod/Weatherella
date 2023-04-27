//
//  LocationPanel.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import SwiftUI

struct LocationPanel: View {
    @State var content: String
    
    var body: some View {
        Text(content)
            .font(.title)
            .foregroundColor(.black)
            .shadow(color: .black, radius: 0.5)
            .multilineTextAlignment(.center)
    }
}


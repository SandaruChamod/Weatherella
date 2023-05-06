//
//  IconLabel.swift
//  Weatherella
//
//  Created by user234080 on 5/5/23.
//

import SwiftUI

/**
 Icon Label
 */
struct IconLabel: View {
    @State var icon: String
    @State var label: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .symbolRenderingMode(.multicolor)
            Text(label)
        }
    }
}


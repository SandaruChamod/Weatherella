//
//  Int+Extensions.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import Foundation

extension Int {
    func convertToSingleDecimal() -> String {
//        let string = String(format: "%.1f", self)
        return Double(self).convertToSingleDecimal()
    }
}

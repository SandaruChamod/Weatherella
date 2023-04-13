//
//  Double+Extensions.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

extension Double {
    func getDateFromUTCTimestamp() -> Date {
        let date = Date(timeIntervalSince1970: self)
        return date
    }
    
    func convertToSingleDecimal() -> String {
        let string = String(format: "%.1f", self)
        return string
    }
}

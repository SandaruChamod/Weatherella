//
//  Double+Extensions.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

extension Double {
    /**
     Responsible to return date object from UTC timestamp.
     Returns Date
     */
    func getDateFromUTCTimestamp() -> Date {
        let date = Date(timeIntervalSince1970: self)
        return date
    }
    
    /**
     Responsible to return given decimal value with one decimal point.
     Returns String
     */
    func convertToSingleDecimal() -> String {
        let string = String(format: "%.1f", self)
        return string
    }
    
    /**
     Responsible to return given decimal value with two decimal points.
     Returns String
     */
    func convertToTwoDecimals() -> String {
        let string = String(format: "%.2f", self)
        return string
    }
}

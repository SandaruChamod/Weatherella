//
//  Int+Extensions.swift
//  Weatherella
//
//  Created by user234080 on 4/17/23.
//

import Foundation

extension Int {
    /**
     Responsible to return given value with one decimal point.
     Returns String
     */
    func convertToSingleDecimal() -> String {
        return Double(self).convertToSingleDecimal()
    }
    
    /**
     Responsible to return date object from UTC timestamp.
     Returns Date
     */
    func getDateFromUTCTimestamp() -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
}

//
//  Keys.swift
//  Weatherella
//
//  Created by user234080 on 4/13/23.
//

import Foundation

/**
    Responsible to convert degrees value to cardinal values
    Returns String
 */
func convertDegToCardinal(deg: Int) -> String {
    let cardinalDir = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
    
    return cardinalDir[Int(round(((Double)(deg % 360)) / 22.5).nextDown) + 1]
}

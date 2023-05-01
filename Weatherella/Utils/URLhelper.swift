//
//  URLhelper.swift
//  Weatherella
//
//  Created by user234080 on 4/27/23.
//

import Foundation

/**
    Responsible to encode given URL string.
    Returns String
 */
func urlEncodeString(stringValue: String) -> String {
    return stringValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

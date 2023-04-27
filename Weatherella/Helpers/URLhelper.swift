//
//  URLhelper.swift
//  Weatherella
//
//  Created by user234080 on 4/27/23.
//

import Foundation

func urlEncodeString(stringValue: String) -> String {
    return stringValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

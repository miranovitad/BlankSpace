//
//  Formatter.swift
//  BlankSpace
//
//  Created by Bryan Khufa on 14/10/21.
//

import Foundation

class Formatter {
    static func dateFormating() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
    static func fullDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy hh:mm:ss a"
        let fullDateString = dateFormatter.string(from: date)
        return fullDateString
    }
    static func changeDateFormat(date: Date) -> String {
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
}

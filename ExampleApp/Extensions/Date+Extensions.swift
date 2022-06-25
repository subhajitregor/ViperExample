//
//  Date+Extensions.swift
//  ExampleApp
//
//  Created by subhajit on 25/06/22.
//

import Foundation

extension Date {
    func toString(from df: DateFormatter) -> String  {
        df.string(from: self)
    }
}

extension DateFormatter {
    static var hhmmssFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()
}

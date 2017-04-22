//
//  CommonFunctions.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import Foundation
private let dateFormatterMMSS = DateFormatter()
private let dateFormatterMMSS_SS = DateFormatter()
class CommonFunctions {
    //Mark: Get String hh:mm from Date
    static func getStringInMMSS(timeInterval:TimeInterval)->String{
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeInterval))
        if dateFormatterMMSS.dateFormat == "" {
            dateFormatterMMSS.dateStyle = .none
            dateFormatterMMSS.timeStyle = .full
            dateFormatterMMSS.timeZone = TimeZone(identifier: "UTC")
            dateFormatterMMSS.dateFormat = "mm:ss"
        }
        return dateFormatterMMSS.string(from: date)
    }
    static func getStringInMMSS_SS(timeInterval:TimeInterval)->String{
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeInterval))
        if dateFormatterMMSS_SS.dateFormat == "" {
            dateFormatterMMSS_SS.dateStyle = .none
            dateFormatterMMSS_SS.timeStyle = .full
            dateFormatterMMSS_SS.timeZone = TimeZone(identifier: "UTC")
            dateFormatterMMSS_SS.dateFormat = "mm:ss.S"
        }
        return dateFormatterMMSS_SS.string(from: date)
    }
}

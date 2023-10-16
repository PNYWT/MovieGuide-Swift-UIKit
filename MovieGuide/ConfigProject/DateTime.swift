//
//  DateTime.swift
//  MovieGuide
//
//  Created by CallmeOni on 12/10/2566 BE.
//

import Foundation

class DateTime{
    
    // MARK: - Convert date format
    static func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }

    static func numberformatter(number:Int?) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        if let number_Tmp = number{
            let formattedNumber = formatter.string(from: NSNumber(value: number_Tmp))!
            return formattedNumber
        }else{
            return "\(number ?? 0)"
        }
    }

    static func convertToTimeFormat(_ minutes: Int) -> String {
        let hours = minutes / 60
        let minutes = minutes % 60
        let hoursString = String(format: "%2d", hours)
        let minutesString = String(format: "%02d", minutes)
        return "\(hoursString)h \(minutesString)m"
    }

    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // รูปแบบวันที่ตามที่คุณต้องการ

        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        return dateString
    }
}

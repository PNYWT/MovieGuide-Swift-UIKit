//
//  DateTime.swift
//  MovieGuide
//
//  Created by CallmeOni on 12/10/2566 BE.
//

import Foundation

class DateTime{
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // รูปแบบวันที่ตามที่คุณต้องการ

        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        return dateString
    }
}

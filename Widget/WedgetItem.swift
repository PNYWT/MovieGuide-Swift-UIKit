//
//  File.swift
//  MovieGuide
//
//  Created by CallmeOni on 15/10/2566 BE.
//

import Foundation

struct WedgetItem:Codable{
    var id = UUID()
    var title:String
    var icon:String
    var detail_1:String
    var detail_2:String
    var isPrimary = false
}

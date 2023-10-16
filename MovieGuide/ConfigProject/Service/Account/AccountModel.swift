//
//  AccountModel.swift
//  MovieGuide
//
//  Created by Dev on 15/10/2566 BE.
//

import Foundation

struct AccountModel{
    let uid:String?
    let displayName:String?
    let photoURL:String?
    let email:String?
    let phoneNumber:String?
    
    private enum CodingKeys: String, CodingKey{
        case uid, displayName, photoURL, email, phoneNumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decodeToAnyString(forKey: .uid)
        displayName = try container.decodeToAnyString(forKey: .displayName)
        photoURL = try container.decodeToAnyString(forKey: .photoURL)
        email = try container.decodeToAnyString(forKey: .email)
        phoneNumber = try container.decodeToAnyString(forKey: .phoneNumber)
    }
}

//
//  ConfigApp.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import Foundation

let spaceDefualt:CGFloat = 8

let showLog = true

func logResponse(url:String,status:Int,data:Data?,_type: APIStatus){
    guard let components = URLComponents(string: url)?.url else{
        return
    }
    
    if let dataSucc = data, showLog == true{
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: dataSucc, options: [])
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) ?? ""
            switch _type{
            case .REQUEST:
                print("url : \(components) -----> REQUEST \n status code -> \(status)")
                print(prettyJsonString)
            case .RESPONSE:
                print("url : \(components)  <------ RESPONSE \n status code -> \(status)")
                print(prettyJsonString)
            }
        }catch let error{
            print("logResponse ->  \(error.localizedDescription)")
        }
    }
}



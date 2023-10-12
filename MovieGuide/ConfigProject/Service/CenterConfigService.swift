//
//  CenterConfigService.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/10/2566 BE.
//

import Foundation

class CenterConfigService{
    
    static func defualtParameter(param:[String:Any])->[String:Any]{
        var paramTemp = param
        if paramTemp["api_key"] == nil{
            paramTemp["api_key"]  = api_key
        }
        
        if paramTemp["language"] == nil{
            paramTemp["language"] = "en-US"
        }
        return paramTemp
    }
}

//
//  CenterConfigService.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/10/2566 BE.
//

import Foundation
import Alamofire

struct RetReturn{
    var page:String?
    var total_pages:String?
    var total_results:String?
    var results:String?
    
    private enum CodingKeys: String, CodingKey{
        case page
        case total_pages
        case total_results
        case results
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        page = try container.decodeIfPresent([GetMenuData].self, forKey: .page)
//        total_pages = try container.decodeIfPresent([GetMenuData].self, forKey: .total_pages)
//        total_results = try container.decodeIfPresent([GetMenuData].self, forKey: .total_results)
//        results = try container.decodeIfPresent([GetMenuData].self, forKey: .results)
//    }
}

class CenterConfigService{
    
    static func customFire(_ urlFire:String, parameters: [String: Any]?, completion: @escaping (Result<Data, Error>) -> Void){
        
        guard let components = URLComponents(string: urlFire)?.url else{
            return
        }
        
        let parameterDefualt = CenterConfigService.defualtParameter(param: parameters ?? [:])
        
        let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODZmYWZmMDMwNDQyMGQ4MGE0ZWI8NjI0ZGQzYTY2NSIsInN1YiI6IjY0MWRjM2Q5ZTBlYzUxMDBiODVhZjJkZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pyI0Mu8G4G4HWHDDP6mzp5ABYLsUTuFLOhqtJx8NNs0"
            ]
        
        if showLog{
            print(String.init(format: "API SEND ------------------------------> %@\n%@", "\(components)", parameterDefualt))
        }
        
        AF.request(urlFire, method: .get, parameters: parameterDefualt, headers: headers)
            .response { responseData in
                if let httpResponse = responseData.response {
                    // ดึงรหัสสถานะ HTTP
                    let statusCode = httpResponse.statusCode
                    print("Status Code: \(statusCode)")
                }
                
                switch responseData.result {
                case .success:
                    guard let jsonData = responseData.data else { return }
                    do {
                        if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
                            let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) ?? ""
                            if showLog{
                                print(String.init(format: "API Response <------------------------------ %@\n%@", "\(components)", "\(prettyJsonData)"))
                            }
                        }
                        completion(.success(jsonData))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
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

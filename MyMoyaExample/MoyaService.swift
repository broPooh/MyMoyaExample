//
//  MoyaService.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import Foundation
import Moya


enum MoyaService {
    case searchTV(String)
}

extension MoyaService: TargetType {
    var baseURL: URL {
        return URL(string: URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchTV: return "/search/tv"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchTV: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchTV(let query): return .requestParameters(parameters: [
            "api_key": "\(APIKEY.apiKey)",
            "query": "\(query)",
            "language": "ko-KR",
            "region": "ko-KR"
        ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

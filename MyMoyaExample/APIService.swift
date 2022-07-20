//
//  APIService.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import Foundation

final class APIService {

    private init() { }
        
    static func searchTvShows(text: String, completion: @escaping (Result<TvShows, TmdbAPISearchError>) -> Void) {

        guard let compoenet = makeURLComponents(url: Endpoint.search.urlString, params: [
            "api_key": "\(APIKEY.apiKey)",
            "query": "\(text)",
            "language": "ko-KR",
            "region": "ko-KR"
        ]) else { return }
        let request = URLRequest(url: compoenet.url!)
        URLSession.requestResultType(endpoint: request, completion: completion)
    }
    
    static func searchTvShowsDelegate(text: String, delegate: URLSessionDataDelegate) {
        print("APIService delegate 검색 호출")
        guard let compoenet = makeURLComponents(url: Endpoint.search.urlString, params: [
            "api_key": "\(APIKEY.apiKey)",
            "query": "\(text)",
            "language": "ko-KR",
            "region": "ko-KR"
        ]) else { return }
        let request = URLRequest(url: compoenet.url!)
        //URLSession.requestResultType(endpoint: request, completion: completion)
        URLSession.requestDelegate(URLSession(configuration: .default, delegate: delegate, delegateQueue: .main), endpoint: request)
    }
    
    static func makeURLComponents(url: String, params: [String: String]) -> URLComponents? {
        guard var component = URLComponents(string: url) else { return nil}
        component.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return component
    }
    
    static func makeURLRequestFromComponent(component: URLComponents, method: HTTPMethod = .GET, header: (key: String, value: String)) -> URLRequest {
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        //request.setValue(header.0, forHTTPHeaderField: header.1)
        request.setValue(header.value, forHTTPHeaderField: header.key)
        return request
    }
    
}

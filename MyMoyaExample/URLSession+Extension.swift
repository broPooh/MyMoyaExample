//
//  URLSession+Extension.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import Foundation

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func requestDelegate(_ session: URLSession, endpoint: URLRequest) {
        session.dataTask(with: endpoint).resume()
    }
    
    static func requestResultType<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (Result<T, TmdbAPISearchError>) -> ()) {

        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure((.failed)))
                    return
                }
                guard let data = data else {
                    completion(.failure((.noData)))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure((.invalidResponse)))
                    return
                }
                guard response.statusCode == TmdbStatusCode.ok.rawValue else {
                    completion(.failure(TmdbAPISearchError(rawValue: response.statusCode) ?? .unknown))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure((.invalidData)))
                }
            }
        }.resume()
    }

}

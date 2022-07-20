//
//  APIEnum.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import Foundation

enum Endpoint {
    case search
}

extension Endpoint {
    var urlString: String {
        switch self {
        case .search: return "\(URL.baseURL)/search/tv"
        }
    }
}



enum APIKEY {
    static let apiKey = "26f86956890fd5c2c8e65d242960dc30"
}

enum APIError: String, Error {
    case unknownError = "error_unknown"
    case serverError = "error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

enum TmdbStatusCode: Int {
    case ok = 200
}

enum TmdbAPISearchError: Int, Error {
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case tooManyRequest = 429
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case unknown
    case failed
    case invalidResponse
    case noData
    case invalidData


    var description: String { self.errorDescription }
}

extension TmdbAPISearchError {

    var errorDescription: String {
        switch self {
        case .badRequest: return "400: 일반적인 오류"
        case .unAuthorized: return "401: 인증 오류"
        case .forbidden: return "403: 권한 오류"
        case .tooManyRequest: return "429: 쿼터 초과"
        case .internalServerError: return "500: 시스템 오류"
        case .badGateway: return "502: 시스템 오류"
        case .serviceUnavailable: return "503: 서비스 점검중"
        case .failed: return "네트워크통신 실패"
        case .invalidData: return "시리얼라이즈 실패"
        default: return "UN_KNOWN_ERROR"
        }
    }
}

enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
}

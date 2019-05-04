//
//  Router.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Alamofire

public enum Router: URLRequestConvertible {
    
    // MARK: - API List
    case createUser(kakaoToken: String)
    
    // MARK: - API HTTP Methods
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        }
    }
    
    // MARK: - API Paths
    var path: String {
        switch self {
        case .createUser:
            return "/api/signin/"
        }
    }
    
    // MARK: - API HTTP Parameters
    var parameters: [String: Any] {
        switch self {
        case .createUser(let kakaoToken):
            return ["acccess_token": kakaoToken]
        default:
            return [:]
        }
    }
    
    var timeoutInterval: Double {
        switch self {
        default:
            return 10
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "http://192.168.0.131:8000"
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        request.httpMethod = method.rawValue
        
        // Timeout values
        request.timeoutInterval = TimeInterval(timeoutInterval) // seconds
        
        
        // Parameters
        switch self {
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
}


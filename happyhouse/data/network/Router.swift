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
    case createTask(name: String, assigneeId: Int)
    case createFamily(myId: Int, friendId: Int) 
    
    // MARK: - API HTTP Methods
    var method: HTTPMethod {
        switch self {
        case .createUser, .createTask, .createFamily:
            return .post
        }
    }
    
    // MARK: - API Paths
    var path: String {
        switch self {
        case .createUser:
            return "/api/signin/"
        case .createTask:
            return "/api/task/"
        case .createFamily(let myId, _):
            return "/api/share/\(myId)/"
        }
    }
    
    // MARK: - API HTTP Parameters
    var parameters: [String: Any] {
        switch self {
        case .createUser(let kakaoToken):
            return ["access_token": kakaoToken]
        case .createTask(let name, let assigneeId):
            return ["housework_name": name, "assignee_id": assigneeId]
        case .createFamily(_, let friendId):
            return ["sharing_user_id": friendId]
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


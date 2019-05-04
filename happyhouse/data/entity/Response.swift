//
//  Response.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

struct Response<T: Codable> : Codable {
    let message: String
    let result: T?
}

extension Response {
    enum CodingKeys : String, CodingKey {
        case message = "msg"
        case result
    }
}



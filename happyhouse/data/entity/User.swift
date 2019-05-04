//
//  User.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

struct User: Codable {
    let nickname: String
    let profileUrl: String
}

extension User {
    enum CodingKeys : String, CodingKey {
        case nickname
        case profileUrl = "profile_url"
    }
}

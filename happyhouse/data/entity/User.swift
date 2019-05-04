//
//  User.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

struct User: Codable {
    let userUid: Int
    let nickname: String
    let profileUrl: String?
}

extension User {
    enum CodingKeys : String, CodingKey {
        case userUid = "user_uid"
        case nickname
        case profileUrl = "profile_url"
    }
}

//
//  Family.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Foundation

struct Family: Codable {
    let id: Int
}

extension Family {
    enum CodingKeys : String, CodingKey {
        case id = "family_id"
    }
}

//
//  HouseWork.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Foundation

struct HouseWork: Codable {
    let name: String
    let assigneeId: Int
    var isDone: Bool
}

extension HouseWork {
    enum CodingKeys : String, CodingKey {
        case name = "housework_name"
        case assigneeId = "assignee_id"
        case isDone = "is_done"
    }
}

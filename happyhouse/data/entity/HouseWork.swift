//
//  HouseWork.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import Foundation

struct HouseWork {
    let name: String
    var isDone: Bool
}

extension HouseWork {
    enum CodingKeys : String, CodingKey {
        case name
        case isDone = "is_done"
    }
}

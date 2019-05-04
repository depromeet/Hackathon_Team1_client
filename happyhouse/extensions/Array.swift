//
//  Array.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

extension Array {

    func item(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

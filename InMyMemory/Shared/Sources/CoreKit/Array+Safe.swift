//
//  Array+Safe.swift
//
//
//  Created by 홍성준 on 12/30/23.
//

import Foundation

public extension Array {
    
    subscript(safe index: Index) -> Element? {
        self.indices ~= index ? self[index] : nil
    }
    
}

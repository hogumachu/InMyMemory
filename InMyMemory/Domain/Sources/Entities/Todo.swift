//
//  Todo.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation

public struct Todo {
    
    public let id: UUID
    public let note: String
    public let isCompleted: Bool
    public let date: Date
    
    public init(
        id: UUID, 
        note: String,
        isCompleted: Bool, 
        date: Date
    ) {
        self.id = id
        self.note = note
        self.isCompleted = isCompleted
        self.date = date
    }
    
}

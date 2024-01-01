//
//  TodoModel.swift
//
//
//  Created by 홍성준 on 1/1/24.
//

import Foundation
import SwiftData
import Entities

@Model
public final class TodoModel {
    
    @Attribute(.unique) public let id: UUID
    public let note: String
    public let isCompleted: Bool
    public let date: Date
    public let updatedAt: Date
    
    public init(
        id: UUID,
        note: String,
        isCompleted: Bool,
        date: Date,
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.note = note
        self.isCompleted = isCompleted
        self.date = date
        self.updatedAt = updatedAt
    }
    
    public convenience init(todo: Todo) {
        self.init(
            id: todo.id,
            note: todo.note,
            isCompleted: todo.isCompleted,
            date: todo.date
        )
    }
    
}

public extension TodoModel {
    
    func toEntity() -> Todo {
        return .init(
            id: id,
            note: note,
            isCompleted: isCompleted,
            date: date
        )
    }
    
}

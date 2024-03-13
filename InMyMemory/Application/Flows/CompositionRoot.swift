//
//  CompositionRoot.swift
//  InMyMemory
//
//  Created by 홍성준 on 1/15/24.
//

import Swinject
import PersistentStorages
import Repositories
import UseCases
import BasePresentation
import HomePresentation
import CalendarPresentation
import RecordPresentation
import MemoryDetailPresentation
import MemoryRecordPresentation
import EmotionDetailPresentation
import EmotionRecordPresentation
import TodoRecordPresentation
import SearchPresentation

enum CompositionRoot {
    
    static func makeAssemblies() -> [Assembly] {
        return [
            StorageAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            BasePresentationAssembly(),
            HomeAssembly(),
            CalendarAssembly(),
            RecordAssembly(),
            MemoryDetailAssembly(),
            MemoryRecordAssembly(),
            EmotionDetailAssembly(),
            EmotionRecordAssembly(),
            SearchAssembly(),
            TodoRecordAssembly()
        ]
    }
    
}

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
import EmotionRecordPresentation
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
            EmotionRecordAssembly(),
            SearchAssembly()
        ]
    }
    
}

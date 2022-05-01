//
//  DatabaseManager.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//

import Foundation

struct DatabaseManager
{
    private let _resumeRepository : ResumeDataRepository = ResumeDataRepository()
    private let seedData = SeedData()

    func createResume(title: String)
    {
        _resumeRepository.create(record: seedData.getDefaultResumeData(title: title))
    }

    func getAllResume() -> [Resume]?
    {
        return _resumeRepository.getAll()
    }
    
    func updateResume(record: Resume) -> Bool
    {
        return _resumeRepository.update(record: record)
    }

    func deleteResume(byIdentifier id: UUID) -> Bool
    {
        return _resumeRepository.delete(byIdentifier: id)
    }
}

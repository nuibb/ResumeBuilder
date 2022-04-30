//
//  ResumeDataRepository.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//

import Foundation
import CoreData

//Implementing repository design pattern
protocol ResumeRepository : BaseRepository {

}

struct ResumeDataRepository : ResumeRepository {
    
    typealias T = Resume
    let handler = DatabaseHandler.shared
    
//    func mapper<T>(object: T) -> NSManagedObject {
//        switch (T.self) {
//        case is Resume.Type:
//            return CDResume() as CDResume
//        default:
//            print("")
//        }
//    }
    
    func create(record: Resume) {
        
        //let cdResume = mapper(object: object) as! CDResume
        
        guard let cdResume = handler.add(CDResume.self) else { return }
        cdResume.id = record.id
        cdResume.title = record.title
        
        if(record.profile != nil)
        {
            guard let cdProfile = handler.add(CDProfile.self) else { return }
            cdResume.profile = record.profile?.toMap(cdProfile: cdProfile)
        }
        
        if(record.basicSections != nil)
        {
            guard let cdBasic = handler.add(CDBasic.self) else { return }
            var basicSet = Set<CDBasic>()
            record.basicSections?.forEach({ (basicSection) in
                basicSet.insert(basicSection.toMap(cdBasic: cdBasic))
            })
            
            cdResume.basic = basicSet
        }
        
        if(record.advancedSections != nil)
        {
            guard let cdAdvanced = handler.add(CDAdvanced.self) else { return }
            var advancedSet = Set<CDAdvanced>()
            record.advancedSections?.forEach({ (advancedSection) in
                guard let section = advancedSection.toMap(cdAdvanced: cdAdvanced) else { return }
                advancedSet.insert(section as! CDAdvanced)
            })
            
            cdResume.advanced = advancedSet
        }
        
        handler.save()
    }

    func getAll() -> [Resume]? {

        let results = handler.fetch(CDResume.self)

        var resumes : [Resume] = []

        results.forEach({ (cdResume) in
            resumes.append(cdResume.convertToResume())
        })

        return resumes
    }

    func get(byIdentifier id: UUID) -> Resume? {

        let fetchRequest = NSFetchRequest<CDResume>(entityName: "CDResume")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result?.convertToResume()

        } catch let error {
            debugPrint(error)
        }

        return nil
    }

    func update(record: Resume) -> Bool {
        return true
    }
    
    func delete(byIdentifier id: UUID) -> Bool {
        let cdResume = getCdResume(byId: id)
        guard cdResume != nil else {return false}

        PersistentStorage.shared.context.delete(cdResume!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getCdResume(byId id: UUID) -> CDResume?
    {
        let fetchRequest = NSFetchRequest<CDResume>(entityName: "CDResume")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}

        return result.first
    }
}


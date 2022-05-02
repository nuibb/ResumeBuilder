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
    //func addSection(type: Template, into record: inout Resume) -> Bool
    func addBasicSection(section: BasicSection, into record: Resume) -> Bool
    func addAdvancedSection(section: AdvancedSection, into record: Resume) -> Bool
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
        
        guard let cdProfile = handler.add(CDProfile.self) else { return }
        cdResume.profile = record.profile.toMap(cdProfile: cdProfile)
        
        var basicSet = Set<CDBasic>()
        
        record.basicSections.forEach({ (basicSection) in
            guard let cdBasic = handler.add(CDBasic.self) else { return }
            basicSet.insert(basicSection.toMap(cdBasic: cdBasic))
        })
        
        cdResume.basic = basicSet
        
        var advancedSet = Set<CDAdvanced>()
        record.advancedSections.forEach({ (advancedSection) in
            guard let cdAdvanced = handler.add(CDAdvanced.self) else { return }
            guard let section = advancedSection.toMap(cdAdvanced: cdAdvanced) else { return }
            advancedSet.insert(section as! CDAdvanced)
        })
        
        cdResume.advanced = advancedSet
        
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
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = handler.fetch(CDResume.self, with: predicate)
        
        //guard let cdResume = handler.add(CDResume.self) else { return false}
        //cdResume.title = record.title
        return true
    }
    
    func delete(byIdentifier id: UUID) -> Bool {
        let cdResume = getCDResume(byId: id)
        guard cdResume != nil else {return false}
        
        PersistentStorage.shared.context.delete(cdResume!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getCDResume(byId id: UUID) -> CDResume?
    {
        let fetchRequest = NSFetchRequest<CDResume>(entityName: "CDResume")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        
        let result = try! PersistentStorage.shared.context.fetch(fetchRequest)
        guard result.count != 0 else {return nil}
        
        return result.first
    }
    
    func addBasicSection(section: BasicSection, into record: Resume) -> Bool {
        let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        let results = handler.fetch(CDResume.self, with: predicate)
        guard results.count != 0, let cdResume = results.first else {return false}
        guard let cdBasic = handler.add(CDBasic.self) else { return false}
        let cdResult = cdResume.basic?.insert(section.toMap(cdBasic: cdBasic))
        if let result = cdResult, result.inserted {
            handler.save()
            return true
        }
        return false
    }
    
    func addAdvancedSection(section: AdvancedSection, into record: Resume) -> Bool {
        let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        let results = handler.fetch(CDResume.self, with: predicate)
        guard results.count != 0, let cdResume = results.first else {return false}
        guard let cdAdvanced = handler.add(CDAdvanced.self) else { return false}
        guard let cdAdvancedSection = section.toMap(cdAdvanced: cdAdvanced) else { return false}
        let cdResult = cdResume.advanced?.insert(cdAdvancedSection as! CDAdvanced)
        if let result = cdResult,  result.inserted {
            handler.save()
            return true
        }
        return false
    }
    
//    func addSection(type: Template, into record: inout Resume) -> Bool {
//        print(type)
//        print(record)
//        let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
//        let results = handler.fetch(CDResume.self, with: predicate)
//        guard results.count != 0, let cdResume = results.first else {return false}
//
//        if type.self == Template.Basic {
//            let basicSection = BasicSection(_title: "Basic", _contents: "", _bulleted: false)
//            guard let cdBasic = handler.add(CDBasic.self) else { return false}
//            let cdResult = cdResume.basic?.insert(basicSection.toMap(cdBasic: cdBasic))
//            if let result = cdResult, result.inserted {
//                record.basicSections.append(basicSection)
//                return true
//            }
//        } else {
//            let organization = Organization(_title: "", _name: "", _role: "", _roleTitle: "", _period: "", _content: "")
//            let advancedSection = AdvancedSection(_title: "Advanced", _organizations: [organization])
//            guard let cdAdvanced = handler.add(CDAdvanced.self) else { return false}
//            guard let cdAdvancedSection = advancedSection.toMap(cdAdvanced: cdAdvanced) else { return false}
//            let cdResult = cdResume.advanced?.insert(cdAdvancedSection as! CDAdvanced)
//            if let result = cdResult,  result.inserted {
//                record.advancedSections.append(advancedSection)
//                return true
//            }
//        }
//        return false
//    }
}


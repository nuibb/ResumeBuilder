//
//  CDResume+CoreDataProperties.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//
//

import Foundation
import CoreData


extension CDResume {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDResume> {
        return NSFetchRequest<CDResume>(entityName: "CDResume")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profile: CDProfile?
    @NSManaged public var basic: Set<CDBasic>?
    @NSManaged public var advanced: Set<CDAdvanced>?

}

// MARK: Generated accessors for basic
extension CDResume {

    @objc(addBasicObject:)
    @NSManaged public func addToBasic(_ value: CDBasic)

    @objc(removeBasicObject:)
    @NSManaged public func removeFromBasic(_ value: CDBasic)

    @objc(addBasic:)
    @NSManaged public func addToBasic(_ values: Set<CDBasic>)

    @objc(removeBasic:)
    @NSManaged public func removeFromBasic(_ values: Set<CDBasic>)

}

// MARK: Generated accessors for advanced
extension CDResume {

    @objc(addAdvancedObject:)
    @NSManaged public func addToAdvanced(_ value: CDAdvanced)

    @objc(removeAdvancedObject:)
    @NSManaged public func removeFromAdvanced(_ value: CDAdvanced)

    @objc(addAdvanced:)
    @NSManaged public func addToAdvanced(_ values: Set<CDAdvanced>)

    @objc(removeAdvanced:)
    @NSManaged public func removeFromAdvanced(_ values: Set<CDAdvanced>)

}

extension CDResume : Identifiable {

}

extension CDResume {
    
    func convertToResume() -> Resume
    {
        return Resume(id: self.id!, title: self.title!, profile: self.profile!.convertToProfile(), basicSections: convertToBasicSections(), advancedSections: convertToAdvancedSection())
    }
    
    private func convertToBasicSections() -> [BasicSection]?
    {
        guard self.basic != nil && self.basic?.count != 0 else {return nil}

        var basicSections: [BasicSection] = []

        self.basic?.forEach({ (cdBasic) in
            basicSections.append(cdBasic.convertToBasicSection())
        })

        return basicSections
    }
    
    private func convertToAdvancedSection() -> [AdvancedSection]?
    {
        guard self.advanced != nil && self.advanced?.count != 0 else {return nil}

        var advancedSections: [AdvancedSection] = []

        self.advanced?.forEach({ (cdAdvanced) in
            advancedSections.append(cdAdvanced.convertToAdvancedSection())
        })

        return advancedSections
    }
}

//
//  CDBasic+CoreDataProperties.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//
//

import Foundation
import CoreData


extension CDBasic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBasic> {
        return NSFetchRequest<CDBasic>(entityName: "CDBasic")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var bulleted: Bool
    @NSManaged public var contents: String?
    @NSManaged public var title: String?
    @NSManaged public var resume: CDResume?

}

extension CDBasic : Identifiable {

}

extension CDBasic {
    
    func convertToBasicSection() -> BasicSection
    {
        return BasicSection(_id: self.id!, _title: self.title!, _contents: self.contents!, _bulleted: self.bulleted)
    }
}

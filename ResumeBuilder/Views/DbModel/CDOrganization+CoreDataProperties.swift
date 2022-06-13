//
//  CDOrganization+CoreDataProperties.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//
//

import Foundation
import CoreData


extension CDOrganization {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDOrganization> {
        return NSFetchRequest<CDOrganization>(entityName: "CDOrganization")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var contentTitle: String?
    @NSManaged public var name: String?
    @NSManaged public var period: String?
    @NSManaged public var role: String?
    @NSManaged public var roleTitle: String?
    @NSManaged public var title: String?
    @NSManaged public var advanced: CDAdvanced?

}

extension CDOrganization : Identifiable {

}

extension CDOrganization {
    
    func convertToOrganization() -> Organization
    {
        return Organization(_id: id!, _title: self.title!, _name: self.name!, _role: self.role!, _roleTitle: self.roleTitle!, _period: self.period!, _contentTitle: self.contentTitle!, _content: self.content!)
    }
}

//
//  CDProfile+CoreDataProperties.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/1/22.
//
//

import Foundation
import CoreData


extension CDProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProfile> {
        return NSFetchRequest<CDProfile>(entityName: "CDProfile")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var address: String?
    @NSManaged public var avatar: Data?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var title: String?
    @NSManaged public var resume: CDResume?

}

extension CDProfile : Identifiable {

}

extension CDProfile {
    
    func convertToProfile() -> Profile?
    {
        return Profile(_id: self.id!, _title: self.title!, _name: self.name!, _address: self.address!, _phone: self.phone!, _email: self.email!, _avatar: self.avatar)
    }
}

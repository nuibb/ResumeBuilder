//
//  CDAdvanced+CoreDataProperties.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//
//

import Foundation
import CoreData


extension CDAdvanced {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAdvanced> {
        return NSFetchRequest<CDAdvanced>(entityName: "CDAdvanced")
    }

    @NSManaged public var title: String?
    @NSManaged public var organization: Set<CDOrganization>?
    @NSManaged public var resume: CDResume?

}

// MARK: Generated accessors for organization
extension CDAdvanced {

    @objc(addOrganizationObject:)
    @NSManaged public func addToOrganization(_ value: CDOrganization)

    @objc(removeOrganizationObject:)
    @NSManaged public func removeFromOrganization(_ value: CDOrganization)

    @objc(addOrganization:)
    @NSManaged public func addToOrganization(_ values: Set<CDOrganization>)

    @objc(removeOrganization:)
    @NSManaged public func removeFromOrganization(_ values: Set<CDOrganization>)

}

extension CDAdvanced : Identifiable {

}

extension CDAdvanced {
    
    func convertToAdvancedSection() -> AdvancedSection
    {
        return AdvancedSection(_title: self.title!, _organizations: convertToOrganizations()!)
    }
    
    private func convertToOrganizations() -> [Organization]?
    {
        guard self.organization != nil && self.organization?.count != 0 else {return nil}

        var organizations: [Organization] = []

        self.organization?.forEach({ (cdOrganization) in
            organizations.append(cdOrganization.convertToOrganization())
        })

        return organizations
    }
}

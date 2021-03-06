//
//  AdvancedSection.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct AdvancedSection {
    let id: UUID
    var title: String
    var organizations: [Organization]?
    
    init(_id: UUID, _title: String, _organizations: [Organization])
    {
        self.id = _id
        self.title = _title
        self.organizations = _organizations
    }
    
    func toMap<T: NSManagedObject>(cdAdvanced: CDAdvanced) -> T? {
        cdAdvanced.id = id
        cdAdvanced.title = title
        var organizationSet = Set<CDOrganization>()
        organizations?.forEach({ (organization) in
            guard let cdOrganization = DatabaseHandler.shared.add(CDOrganization.self) else { return }
            organizationSet.insert(organization.toMap(cdOrganization: cdOrganization))
        })

        cdAdvanced.organization = organizationSet
        
        return cdAdvanced as? T
    }
}

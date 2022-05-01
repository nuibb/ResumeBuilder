//
//  AdvancedSection.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct AdvancedSection {
    let title: String
    let organizations: [Organization]?
    
    init(_title: String, _organizations: [Organization])
    {
        self.title = _title
        self.organizations = _organizations
    }
    
    func toMap<T: NSManagedObject>(cdAdvanced: CDAdvanced) -> T? {
        cdAdvanced.title = title
        guard let cdOrganization = DatabaseHandler.shared.add(CDOrganization.self) else { return nil}
        var organizationSet = Set<CDOrganization>()
        organizations?.forEach({ (organization) in
            organizationSet.insert(organization.toMap(cdOrganization: cdOrganization))
        })

        cdAdvanced.organization = organizationSet
        
        return cdAdvanced as? T
    }
}

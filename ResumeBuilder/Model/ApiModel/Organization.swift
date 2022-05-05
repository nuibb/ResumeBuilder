//
//  Content.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct Organization {
    let id: UUID
    let title: String
    var name: String
    var role: String
    let roleTitle: String
    var period: String
    let contentTitle: String
    var content: String
    
    init(_id: UUID, _title: String, _name: String, _role: String, _roleTitle: String, _period: String, _contentTitle: String, _content: String)
    {
        self.id = _id
        self.title = _title
        self.name = _name
        self.role = _role
        self.roleTitle = _roleTitle
        self.period = _period
        self.contentTitle = _contentTitle
        self.content = _content
    }
    
    func toMap<T: NSManagedObject>(cdOrganization: CDOrganization) -> T  {
        cdOrganization.id = id
        cdOrganization.title = title
        cdOrganization.name = name
        cdOrganization.role = role
        cdOrganization.roleTitle = roleTitle
        cdOrganization.period = period
        cdOrganization.contentTitle = contentTitle
        cdOrganization.content = content
        
        return cdOrganization as! T
    }
}

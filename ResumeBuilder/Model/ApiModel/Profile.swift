//
//  Profile.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct Profile  {
    var id: UUID
    var title: String
    var name : String
    var address : String
    var phone : String
    var email : String
    var avatar : Data?
    
    init(_id: UUID, _title: String, _name: String, _address: String, _phone: String, _email: String, _avatar: Data?)
    {
        self.id = _id
        self.title = _title
        self.name = _name
        self.address = _address
        self.phone = _phone
        self.email = _email
        self.avatar = _avatar
    }
    
    func toMap<T: NSManagedObject>(cdProfile: CDProfile) -> T {
        cdProfile.id = id
        cdProfile.title = title
        cdProfile.name = name
        cdProfile.address = address
        cdProfile.phone = phone
        cdProfile.email = email
        cdProfile.avatar = avatar
        
        return cdProfile as! T
    }
}

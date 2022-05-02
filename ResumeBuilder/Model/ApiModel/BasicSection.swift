//
//  BasicSection.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct BasicSection {
    let id: UUID
    var title: String
    var contents: String
    var bulleted: Bool
    
    init(_id: UUID, _title: String, _contents: String, _bulleted: Bool)
    {
        self.id = _id
        self.title = _title
        self.contents = _contents
        self.bulleted = _bulleted
    }
    
    func toMap<T: NSManagedObject>(cdBasic: CDBasic) -> T  {
        cdBasic.id = id
        cdBasic.title = title
        cdBasic.contents = contents
        cdBasic.bulleted = bulleted
        
        return cdBasic as! T
    }
}

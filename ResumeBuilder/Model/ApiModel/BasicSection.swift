//
//  BasicSection.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation
import CoreData

struct BasicSection : Codable {
    let title: String
    let contents: String
    let bulleted: Bool
    
    init(_title: String, _contents: String, _bulleted: Bool)
    {
        self.title = _title
        self.contents = _contents
        self.bulleted = _bulleted
    }
    
    func toMap<T: NSManagedObject>(cdBasic: CDBasic) -> T  {
        cdBasic.title = title
        cdBasic.contents = contents
        cdBasic.bulleted = bulleted
        
        return cdBasic as! T
    }
}

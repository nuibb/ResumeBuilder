//
//  Resume.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation

struct Resume  {
    let id: UUID
    let title: String
    let profile : Profile
    let basicSections : [BasicSection]
    let advancedSections : [AdvancedSection]
    
    init(_id: UUID, _title: String, _profile: Profile, _basicSections: [BasicSection], _advancedSections: [AdvancedSection]) {
        self.id = _id
        self.title = _title
        self.profile = _profile
        self.basicSections = _basicSections
        self.advancedSections = _advancedSections
    }
}

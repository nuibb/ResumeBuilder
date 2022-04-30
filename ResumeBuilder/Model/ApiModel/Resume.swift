//
//  Resume.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation

struct Resume : Codable {
    let id: UUID
    let title: String
    let profile : Profile?
    let basicSections : [BasicSection]?
    let advancedSections : [AdvancedSection]?
}

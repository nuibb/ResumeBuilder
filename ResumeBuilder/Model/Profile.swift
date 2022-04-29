//
//  Profile.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation

struct Profile : Codable {
    let name : String
    let address : String
    let phone : String
    let email : String
    let profilePicture : ProfilePicture?
}

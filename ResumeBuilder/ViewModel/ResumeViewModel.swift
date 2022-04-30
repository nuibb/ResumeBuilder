//
//  ResumeViewModel.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation

struct ResumeViewModel {
    let resume: Resume
    private(set) var title = ""
    
    init(resume: Resume) {
        self.resume = resume
        updateProperties()
    }
    
    //Creating a mutating function allows us to change the properties of the struct.
    private mutating func updateProperties() {
        title = setName(resume: resume)
    }
}

extension ResumeViewModel {
    // Create separate functions for each property.
    private func setName(resume: Resume) -> String {
        return "\(resume.title.uppercased())'S RESUME"
    }
}



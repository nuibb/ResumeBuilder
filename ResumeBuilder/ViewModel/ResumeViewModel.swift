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
    var sections = [Any]()
    
    init(resume: Resume) {
        self.resume = resume
        updateProperties()
        orderingSections()
    }
}

extension ResumeViewModel {
    //Creating a mutating function allows us to change the properties of the struct.
    private mutating func updateProperties() {
        title = setName(resume: resume)
    }
    
    // Create separate functions for each property.
    private func setName(resume: Resume) -> String {
        return "\(resume.title.uppercased())'S RESUME"
    }
}

extension ResumeViewModel {
    //For default ordering in each resume
    private mutating func orderingSections() {
        self.sections.append(self.resume.profile as Any)
        if self.resume.basicSections.count == 3 && self.resume.advancedSections.count == 2 {
            self.sections.append(self.resume.basicSections.first as Any)
            self.sections.append(self.resume.advancedSections.first as Any)
            self.sections.append(self.resume.basicSections[1] as Any)
            self.sections.append(self.resume.advancedSections.last as Any)
            self.sections.append(self.resume.basicSections.last as Any)
        }
    }
}




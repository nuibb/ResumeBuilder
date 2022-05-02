//
//  ResumeViewModel.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/27/22.
//

import Foundation

struct ResumeViewModel {
    var resume: Resume
    private(set) var title = ""
    var sections = [Any]()
    let dbManager = DatabaseManager()
    
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
        
        //Add Basic Info
        self.sections.append(self.resume.profile as Any)
        
        //Add Objectives
        let objectives = self.resume.basicSections.filter{$0.title == Constants.objectiveTitle}
        if objectives.count > 0 {
            self.sections.append(objectives.first as Any)
        }
        
        //Add Work Experience
        let workExperiences = self.resume.advancedSections.filter{$0.title == Constants.workExperienceTitle}
        if workExperiences.count > 0 {
            self.sections.append(workExperiences.first as Any)
        }
        
        //Add Education
        let educationInstitutes = self.resume.advancedSections.filter{$0.title == Constants.educationTitle}
        if educationInstitutes.count > 0 {
            self.sections.append(educationInstitutes.first as Any)
        }
        
        //Add Other Activities
        let otherActivities = self.resume.basicSections.filter{$0.title == Constants.otherActivitiesTitle}
        if otherActivities.count > 0 {
            self.sections.append(otherActivities.first as Any)
        }
        
        //Add References
        let references = self.resume.basicSections.filter{$0.title == Constants.referenceTitle}
        if references.count > 0 {
            self.sections.append(references.first as Any)
        }
        
        //Append other basic sections
        let otherBasicSections = self.resume.basicSections.filter{$0.title != Constants.objectiveTitle && $0.title != Constants.otherActivitiesTitle && $0.title != Constants.referenceTitle}
        if otherBasicSections.count > 0 {
            for section in otherBasicSections {
                self.sections.append(section as Any)
            }
        }
        
        //Append other advanced sections
        let otherAdvancedSections = self.resume.advancedSections.filter{$0.title != Constants.workExperienceTitle && $0.title != Constants.educationTitle}
        if otherAdvancedSections.count > 0 {
            for section in otherAdvancedSections {
                self.sections.append(section as Any)
            }
        }
    }
}

extension ResumeViewModel {
    mutating func addSection(template: Template) -> Bool {
        if template.self == Template.Basic {
            let basicSection = BasicSection(_title: "Basic", _contents: "", _bulleted: false)
            let flag = dbManager.addBasicSection(section: basicSection, into: self.resume)
            if flag {
                self.resume.basicSections.append(basicSection)
                self.sections.append(basicSection)
            }
            return flag
        } else {
            let organization = Organization(_title: "", _name: "", _role: "", _roleTitle: "", _period: "", _content: "")
            let advancedSection = AdvancedSection(_title: "Advanced", _organizations: [organization])
            let flag = dbManager.addAdvancedSection(section: advancedSection, into: self.resume)
            if flag {
                self.resume.advancedSections.append(advancedSection)
                self.sections.append(advancedSection)
            }
            return flag
        }
    }
}


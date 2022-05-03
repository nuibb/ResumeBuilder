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
        if resume.title != Constants.defaultResumeTitle {
            return "\(resume.title.uppercased())'S RESUME"
        }
        return Constants.defaultResumeTitle.uppercased()
    }
}

extension ResumeViewModel {
    //For default ordering in each resume
    private mutating func orderingSections() {
        
        self.sections.removeAll()
        
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
            let basicSection = BasicSection(_id: UUID(), _title: "Basic", _contents: "", _bulleted: false)
            let flag = dbManager.addBasicSection(section: basicSection, into: self.resume)
            if flag {
                self.resume.basicSections.append(basicSection)
                self.sections.append(basicSection)
            }
            return flag
        } else {
            let organization = Organization(_id: UUID(), _title: "", _name: "", _role: "", _roleTitle: "", _period: "", _contentTitle: "", _content: "")
            let advancedSection = AdvancedSection(_id: UUID(), _title: "Advanced", _organizations: [organization])
            let flag = dbManager.addAdvancedSection(section: advancedSection, into: self.resume)
            if flag {
                self.resume.advancedSections.append(advancedSection)
                self.sections.append(advancedSection)
            }
            return flag
        }
    }
}

extension ResumeViewModel {
    mutating func updateBasicSection(section: BasicSection) {
        if dbManager.updateBasicSection(section: section) {
            let matchedSections = self.resume.basicSections.filter{$0.id == section.id}
            guard matchedSections.count > 0, var currentSection = matchedSections.first else { return }
            currentSection.title = section.title
            currentSection.contents = section.contents
            currentSection.bulleted = section.bulleted
            orderingSections()
        }
    }
    
    mutating func updateAdvancedSection(section: AdvancedSection) {
        if dbManager.updateAdvancedSection(section: section) {
            let matchedSections = self.resume.advancedSections.filter{$0.id == section.id}
            guard matchedSections.count > 0, var currentSection = matchedSections.first else { return }
            currentSection.title = section.title
            // MARK: Organization part will be implemented in later version
            orderingSections()
        }
    }
    
    mutating func updateProfile(profile: Profile) {
        if dbManager.updateProfile(profile: profile) {
            self.resume.profile = profile
            self.sections[0] = profile
        }
    }
}



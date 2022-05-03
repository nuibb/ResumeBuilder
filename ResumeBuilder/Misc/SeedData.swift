//
//  SeedData.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/30/22.
//

import Foundation

class SeedData {
    
    init() {
        
    }
    
    func getDefaultResumeData(title: String) -> Resume {
        
        let profile = Profile(_id: UUID(), _title: Constants.basicInfoTitle, _name: "", _address: "", _phone: "", _email: "", _avatar: nil)
        
        // MARK: - Basic Sections
        var basicSections = [BasicSection]()
        let objective = BasicSection(_id: UUID(), _title: Constants.objectiveTitle, _contents: Constants.objectiveContents, _bulleted: false)
        let references = BasicSection(_id: UUID(), _title: Constants.referenceTitle, _contents: Constants.referenceContents, _bulleted: true)
        let otherActivities = BasicSection(_id: UUID(), _title: Constants.otherActivitiesTitle, _contents: Constants.otherActivitiesContents, _bulleted: true)
        basicSections.append(objective)
        basicSections.append(references)
        basicSections.append(otherActivities)
        
        // MARK - Advanced Sections
        var advancedSections = [AdvancedSection]()
        
        // MARK: - Work Organizations
        var workOrganizations = [Organization]()
        let workOrganization1 = Organization(_id: UUID(), _title: Constants.workOrganizationTitle, _name: Constants.workOrganizationName, _role: Constants.workOrganizationRole1, _roleTitle: Constants.workOrganizationRoleTitle, _period: Constants.workOrganizationPeriod1, _contentTitle: Constants.workOrganizationContentTitle, _content: Constants.workOrganizationContent1)
        let workOrganization2 = Organization(_id: UUID(), _title: Constants.workOrganizationTitle, _name: Constants.workOrganizationName, _role: Constants.workOrganizationRole2, _roleTitle: Constants.workOrganizationRoleTitle, _period: Constants.workOrganizationPeriod2, _contentTitle: Constants.workOrganizationContentTitle, _content: Constants.workOrganizationContent2)
        workOrganizations.append(workOrganization1)
        workOrganizations.append(workOrganization2)
        let workExperience = AdvancedSection(_id: UUID(), _title: Constants.workExperienceTitle, _organizations: workOrganizations)
        
        // MARK: - Education Organizations
        var educationInstitutes = [Organization]()
        let educationInstitute1 = Organization(_id: UUID(), _title: Constants.educationTitle, _name: Constants.educationInstituteName1, _role: Constants.educationInstituteRole1, _roleTitle: Constants.educationInstituteRoleTitle, _period: Constants.educationInstitutePeriod1, _contentTitle: Constants.educationInstituteContentTitle, _content: Constants.educationInstituteContent1)
        let educationInstitute2 = Organization(_id: UUID(), _title: Constants.educationTitle, _name: Constants.educationInstituteName2, _role: Constants.educationInstituteRole2, _roleTitle: Constants.educationInstituteRoleTitle, _period: Constants.educationInstitutePeriod2, _contentTitle: Constants.educationInstituteContentTitle, _content: Constants.educationInstituteContent2)
        educationInstitutes.append(educationInstitute1)
        educationInstitutes.append(educationInstitute2)
        let education = AdvancedSection(_id: UUID(), _title: Constants.educationTitle, _organizations: educationInstitutes)
        advancedSections.append(workExperience)
        advancedSections.append(education)
        
        return Resume(_id: UUID(), _title: title, _profile: profile, _basicSections: basicSections, _advancedSections: advancedSections)
    }
}

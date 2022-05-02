//
//  Constants.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/29/22.
//

import Foundation

enum UserDefaultsKeys : String {
    case defaultResumeTitle
}

enum Template {
    case Basic
    case Advanced
}

extension UserDefaults {

    //MARK: Set Default Resume Title
    func setDefaultResumeTitle(value: String) {
        set(value, forKey: UserDefaultsKeys.defaultResumeTitle.rawValue)
        //synchronize()
    }

    //MARK: Retrieve Default Resume Title
    func getDefaultResumeTitle() -> String? {
        return string(forKey: UserDefaultsKeys.defaultResumeTitle.rawValue)
    }
}

class Constants{
    static let defaultResumeTitle = "My Resume"
    static let alertTitle = "Create New Resume"
    static let alertActionTitle = "Add Resume"
    static let templateAlertActionTitle = "Add Template"
    static let templateAlertActionMessage = "Select your preferred template section"
    static let basicTemplateTitle = "Basic"
    static let advancedTemplateTitle = "Advanced"
    static let textFieldPlaceholderText = "Add Your Name"
    static let segueIdentifierNameForResume = "ShowResume"
    static let segueIdentifierForBasicSection = "ShowBasicSection"
    static let segueIdentifierForAdvancedSection = "ShowAdvancedSection"
    static let segueIdentifierForProfile = "ShowProfile"
    static let identifierNameForResumeCell = "ResumeCell"
    static let identifierNameForAdvancedSectionCell = "AdvancedSectionCell"
    
    static let basicInfoTitle = "Basic Info"
    static let objectiveTitle = "Objective"
    static let objectiveContents = "Talented professional manager seeking to fill an executive role."
    static let referenceTitle = "References"
    static let referenceContents = "Reference line item 1\nReference line item 2\nReference line item 3"
    static let otherActivitiesTitle = "Other Activities"
    static let otherActivitiesContents = "Member of the Football club FC Barcelona. I enjoy sport, traveling, reading books as well as outing with friends and families"
    
    // Mark: Work Experience
    static let workExperienceTitle = "Work Experience"
    static let workOrganizationTitle = "Company"
    static let workOrganizationName = "Auto Industries, New York, NY."
    static let workOrganizationRoleTitle = "Designation"
    static let workOrganizationRole1 = "Senior Manager"
    static let workOrganizationRole2 = "Planning Manager"
    static let workOrganizationPeriod1 = "Mar 2020 - Present"
    static let workOrganizationPeriod2 = "June 2019 - April 2022"
    static let workOrganizationContent1 = "Managed a team of 20 people from various background. Built and implemented the production request process for the whole dealer network."
    static let workOrganizationContent2 = "Recruited 5 executive planners to create the new Planning business unit. Reduced stock with 20% by implementing a quicker ordering system."
    
    // Mark: Education
    static let educationTitle = "Education"
    static let educationInstituteTitle = "Institute"
    static let educationInstituteName1 = "Harvard, Boston, MA"
    static let educationInstituteName2 = "Columbia University at New York"
    static let educationInstituteRoleTitle = "Department"
    static let educationInstituteRole1 = "Master in European Business"
    static let educationInstituteRole2 = "B.A. Business"
    static let educationInstitutePeriod1 = "Mar 2017 - April 2019"
    static let educationInstitutePeriod2 = "Feb 2013 - Feb 2017"
    static let educationInstituteContent1 = "Specialized in Marketing and Communication. Achieved 2 honorary awards for final thesis."
    static let educationInstituteContent2 = "Graduated with a 3.6 GPA. Specialized in Commercial Management."
}

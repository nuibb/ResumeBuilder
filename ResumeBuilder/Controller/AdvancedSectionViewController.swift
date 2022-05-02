//
//  AdvancedSectionViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/2/22.
//

import UIKit

class AdvancedSectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var advancedSection: AdvancedSection?
    private var organizations = [Organization]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let section = advancedSection else {return}
        self.title = section.title
        guard let orgs = section.organizations else { return }
        self.organizations = orgs
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.view.endEditing(true)
        }
    }

}

extension AdvancedSectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierNameForAdvancedSectionCell, for: indexPath) as! AdvancedSectionCell
        
        let organization = self.organizations[indexPath.row]
        cell.title.text = "\(indexPath.row + 1). \(organization.title)"
        cell.name.text = organization.name
        cell.roleTitle.text = organization.roleTitle
        cell.role.text = organization.role
        cell.period.text = organization.period
        cell.contentTitle.text = organization.contentTitle
        cell.content.text = organization.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

extension AdvancedSectionViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        
        self.view.endEditing(true)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}

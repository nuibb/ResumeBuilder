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
    weak var delegate: DelegateForUpdatingRepository?
    
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
        
        guard var section = advancedSection else {return}
        section.organizations = self.organizations
        self.delegate?.updateRepository(object: section)
    }
    
    @objc func nameTextFieldDidChange(_ sender: Any) {
        guard let textField = sender as? UITextField else {return}
        guard let name = textField.text else { return }
        let index = textField.tag
        self.organizations[index].name = name
    }
    
    @objc func roleTextFieldDidChange(_ sender: Any) {
        guard let textField = sender as? UITextField else {return}
        guard let role = textField.text else { return }
        let index = textField.tag
        self.organizations[index].role = role
    }
    
    @objc func periodTextFieldDidChange(_ sender: Any) {
        guard let textField = sender as? UITextField else {return}
        guard let period = textField.text else { return }
        let index = textField.tag
        self.organizations[index].period = period
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
        
        cell.name.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        cell.name.tag = indexPath.row
        cell.role.addTarget(self, action: #selector(roleTextFieldDidChange(_:)), for: .editingChanged)
        cell.role.tag = indexPath.row
        cell.period.addTarget(self, action: #selector(periodTextFieldDidChange(_:)), for: .editingChanged)
        cell.period.tag = indexPath.row
        cell.content.tag = indexPath.row

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
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.organizations[textView.tag].content = textView.text
    }
}

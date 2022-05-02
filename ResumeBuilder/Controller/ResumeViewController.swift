//
//  ResumeViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/28/22.
//

import UIKit

class ResumeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var resumeViewModel: ResumeViewModel?
    var numberOfSections: Int = 0
    var resumeSections: [Any] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.rowHeight = 50;
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = resumeViewModel else {return}
        resumeSections = viewModel.sections
        self.title = viewModel.title
    }
}

extension ResumeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resumeSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierNameForResumeCell, for: indexPath) as! ResumeCell
        
        var title = ""
        
        if self.resumeSections[indexPath.row] is BasicSection {
            title = (self.resumeSections[indexPath.row] as! BasicSection).title
        } else if self.resumeSections[indexPath.row] is AdvancedSection {
            title = (self.resumeSections[indexPath.row] as! AdvancedSection).title
        } else {
            title = (self.resumeSections[indexPath.row] as! Profile).title
        }
        
        cell.title.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.resumeSections[indexPath.row] is BasicSection {
            performSegue(withIdentifier: Constants.segueIdentifierForBasicSection, sender: indexPath)
        } else if self.resumeSections[indexPath.row] is AdvancedSection {
            performSegue(withIdentifier: Constants.segueIdentifierForAdvancedSection, sender: indexPath)
        } else {
            performSegue(withIdentifier: Constants.segueIdentifierForProfile, sender: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.resumeSections.remove(at: indexPath.row)

            // MARK: Deleting from core data will be implemented in next version
            
            /*
            let resumeViewModel = self.resumeSections[indexPath.row]
            //if self.dbManager.deleteResume(byIdentifier: resumeViewModel.resume.id) {
                //self.resumes.remove(at: indexPath.row)
                //tableView.deleteRows(at: [indexPath], with: .automatic)
            //}
            */
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

// MARK: Navigation
extension ResumeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifierForBasicSection {
            let controller = segue.destination as! BasicSectionViewController
            guard let indexPath = sender as? IndexPath, let section = self.resumeSections[indexPath.row] as? BasicSection else {return}
            controller.basicSection = section
        } else if segue.identifier == Constants.segueIdentifierForAdvancedSection {
            let controller = segue.destination as! AdvancedSectionViewController
            guard let indexPath = sender as? IndexPath, let section = self.resumeSections[indexPath.row] as? AdvancedSection else {return}
            controller.advancedSection = section
        } else {
            let controller = segue.destination as! ProfileViewController
            guard let indexPath = sender as? IndexPath, let profile = self.resumeSections[indexPath.row] as? Profile else {return}
            controller.profile = profile
        }
    }
}

extension ResumeViewController {
    
    @objc func addSectionButtonTapped(sender: UIButton) {
        showAlertController()
    }
    
    @objc func editSectionButtonTapped(sender: UIButton) {
        self.tableView.setEditing(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = FooterView()
        footerView.addSectionButton.target = self
        footerView.addSectionButton.action = #selector(addSectionButtonTapped(sender:))
        footerView.editSectionButton.target = self
        footerView.editSectionButton.action = #selector(editSectionButtonTapped(sender:))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
}

extension ResumeViewController {
    
    func showAlertController() {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: Constants.templateAlertActionTitle, message: Constants.templateAlertActionMessage, preferredStyle: .alert)
        
        // Create Basic button with action handler
        let basic = UIAlertAction(title: Constants.basicTemplateTitle, style: .default, handler: { (action) -> Void in
            guard var model = self.resumeViewModel else { return }
            if model.addSection(template: .Basic) {
                self.resumeSections.append(model.sections.last as Any)
                self.tableView.reloadData()
            }
        })
        
        // Create Advanced button with action handlder
        let advanced = UIAlertAction(title: Constants.advancedTemplateTitle, style: .default) { (action) -> Void in
            guard var model = self.resumeViewModel else { return }
            if model.addSection(template: .Advanced) {
                self.resumeSections.append(model.sections.last as Any)
                self.tableView.reloadData()
            }
        }
        
        //Add Basic and Advanced button to dialog message
        dialogMessage.addAction(basic)
        dialogMessage.addAction(advanced)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}



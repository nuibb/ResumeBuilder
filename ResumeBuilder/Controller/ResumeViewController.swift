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
        self.tableView.rowHeight = 50;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = resumeViewModel else {return}
        resumeSections = viewModel.sections
        self.title = viewModel.title
    }
    
    @IBAction func addSection(_ sender: Any) {
    }
    
    @IBAction func editSections(_ sender: Any) {
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
        //let selectedCell = tableView.cellForRow(at: indexPath)
       // performSegue(withIdentifier: "ShowResume", sender: indexPath)
    }
}

extension ResumeViewController {
    
    @objc func addSectionButtonTapped(sender: UIButton) {
        print("Add")
    }
    
    @objc func editSectionButtonTapped(sender: UIButton) {
        print("Edit")
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



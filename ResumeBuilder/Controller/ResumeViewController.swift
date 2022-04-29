//
//  ResumeViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/28/22.
//

import UIKit

class ResumeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var resume: ResumeViewModel?
    var numberOfSections: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let resume = self.resume {
//            self.navigationItem.title = resume.name
//            self.numberOfSections = resume.basicSections.count + resume.advancedSections.count
//        }
    }
    
    @IBAction func addSection(_ sender: Any) {
    }
    
    @IBAction func editSections(_ sender: Any) {
    }
}

extension ResumeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierNameForResumeCell, for: indexPath) as! ResumeCell
        if let resume = self.resume {
            cell.title.text = resume.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedCell = tableView.cellForRow(at: indexPath)
       // performSegue(withIdentifier: "ShowResume", sender: indexPath)
    }
}



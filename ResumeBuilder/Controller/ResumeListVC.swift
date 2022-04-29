//
//  ViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 4/26/22.
//

import UIKit
import CoreData

class ResumeListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addResumeButton: UIBarButtonItem!
    
    private let dbManager = DbManager()
    private var resumes = [ResumeViewModel]()
    private(set) var resumeViewModel: ResumeViewModel?
    
    var searchResults: [Resume]? {
        didSet {
            guard let searchResults = searchResults else { return }
            resumes = searchResults.map{ResumeViewModel.init(resume: $0)}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 50;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getResumes()
    }
   
    @IBAction func addResume(_ sender: Any) {
        showAlertControllerToAddResume()
    }
}

extension ResumeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resumes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierNameForResumeCell, for: indexPath) as! ResumeCell
        let resume = self.resumes[indexPath.row] as ResumeViewModel
        cell.title.text = resume.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedCell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: Constants.segueIdentifierNameForResume, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let resumeViewModel = self.resumes[indexPath.row] as ResumeViewModel
            tableView.beginUpdates()
            self.dbManager.deleteObjectFromDb(object: resumeViewModel.resume)
            self.resumes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ResumeListVC {
    
    private func getResumes() {
        dbManager.getResumesFromDb() { (resumes, error) in
            if let error = error {
                print("Got error: \(error.localizedDescription)")
                return
            }
            guard let resumes = resumes  else { return }
            self.searchResults = resumes
        }
    }
}

extension ResumeListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifierNameForResume {
            let resumeViewController = segue.destination as! ResumeViewController
            guard let indexPath = sender as? IndexPath else {return}
            print(self.resumes[indexPath.row])
            resumeViewController.resume = self.resumes[indexPath.row]
        }
    }
}

extension ResumeListVC {
    func showAlertControllerToAddResume() {
        let alert = UIAlertController(title: Constants.alertTitle, message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = Constants.textFieldPlaceholderText
        }

        let action = UIAlertAction(title: Constants.alertActionTitle, style: .default) { [unowned alert] _ in
            guard let textFields = alert.textFields, textFields.count > 0 else { return }
            if let resumeName = textFields[0].text {
                self.dbManager.addResumeIntoDb(name: resumeName)
                self.getResumes()
            }
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



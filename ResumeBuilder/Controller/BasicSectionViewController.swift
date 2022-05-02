//
//  ResumeSectionViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/2/22.
//

import UIKit

class BasicSectionViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    var basicSection: BasicSection?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let section = basicSection else {return}
        self.title = section.title
        updateFields(section: section)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.contentsTextView.layer.borderWidth = 1
        self.contentsTextView.layer.cornerRadius = 10
        self.contentsTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.view.endEditing(true)
        }
    }
    
    func updateFields(section: BasicSection) {
        self.titleTextField.text = section.title
        self.contentsTextView.text = section.contents
    }
    
    @IBAction func toggleSwitch(_ sender: Any) {
        
    }
}

extension BasicSectionViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        basicSection?.title = self.titleTextField.text ?? ""
        self.view.endEditing(true)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        basicSection?.contents = self.contentsTextView.text ?? ""
    }
}


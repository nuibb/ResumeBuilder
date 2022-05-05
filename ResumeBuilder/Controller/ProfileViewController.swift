//
//  ProfileViewController.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    var profile: Profile?
    weak var delegate: DelegateForUpdatingRepository?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let user = profile else {return}
        self.title = user.title
        updateFields(user: user)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.view.endEditing(true)
        }
        
        guard let userProfile = profile else { return }
        self.delegate?.updateRepository(object: userProfile)
    }
    
    func updateFields(user: Profile) {
        usernameTextField.text = user.name
        addressTextField.text = user.address
        phoneNumberTextField.text = user.phone
        emailTextField.text = user.email
        guard let image = user.avatar else { return }
        userProfilePic.image = UIImage(data: image)
    }
    
    @IBAction func usernameTextChanged(_ sender: Any) {
        profile?.name = self.usernameTextField.text!
    }
    
    @IBAction func addressTextChanged(_ sender: Any) {
        profile?.address = self.addressTextField.text!
    }
    
    @IBAction func phoneTextChanged(_ sender: Any) {
        profile?.phone = self.phoneNumberTextField.text!
    }
    
    @IBAction func emailTextChanged(_ sender: Any) {
        profile?.email = self.emailTextField.text!
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
}

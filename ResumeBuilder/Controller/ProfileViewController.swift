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
    }
    
    func updateFields(user: Profile) {
        usernameTextField.text = user.name
        addressTextField.text = user.address
        phoneNumberTextField.text = user.phone
        emailTextField.text = user.email
        guard let image = user.avatar else { return }
        userProfilePic.image = UIImage(data: image)
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField) {
        case self.usernameTextField:
            print(self.usernameTextField.text!)
            profile?.name = self.usernameTextField.text ?? ""
            break
        case self.addressTextField:
            print(self.addressTextField.text!)
            profile?.address = self.addressTextField.text ?? ""
            break
        case self.phoneNumberTextField:
            print(self.phoneNumberTextField.text!)
            profile?.phone = self.phoneNumberTextField.text ?? ""
            break
        case self.emailTextField:
            print(self.emailTextField.text!)
            profile?.email = self.emailTextField.text ?? ""
            break
        default:
            break
        }
    
        if textField == usernameTextField {
            return false
        }
        self.view.endEditing(true)
        return true
    }
}

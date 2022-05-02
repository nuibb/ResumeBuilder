//
//  AdvancedSectionCell.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/2/22.
//

import UIKit

class AdvancedSectionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var roleTitle: UILabel!
    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var period: UITextField!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.content.layer.borderWidth = 1
        self.content.layer.cornerRadius = 10
        self.content.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

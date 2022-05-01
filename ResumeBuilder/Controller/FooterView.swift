//
//  FooterView.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/1/22.
//

import UIKit

class FooterView: UIView {
    
    @IBOutlet weak var addSectionButton: UIBarButtonItem!
    @IBOutlet weak var editSectionButton: UIBarButtonItem!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    

}

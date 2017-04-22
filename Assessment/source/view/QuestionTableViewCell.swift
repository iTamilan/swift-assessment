//
//  QuestionTableViewCell.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(question:Question){
        self.lblText?.text = question.question
        
    }
}

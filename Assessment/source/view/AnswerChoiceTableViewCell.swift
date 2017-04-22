//
//  AnswerChoiceTableViewCell.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit
class AnswerChoiceTableViewCell: UITableViewCell {
    var answerChoice:AnswerChoice! = nil
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblIndex: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lblIndex.layer.borderColor = lblText.textColor.cgColor
        lblIndex.layer.borderWidth = 2.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            lblText.textColor = answerChoice.isRightAnswer ? UIColor.green : UIColor.red
            lblText.font = UIFont.boldSystemFont(ofSize: lblText.font.pointSize)
        }
        // Configure the view for the selected state
    }
    public func configure(question: Question, index:Int,selectedIndex:Int){
        self.answerChoice = question.answerChoices[index]
        if (selectedIndex>=0 && answerChoice.isRightAnswer) || selectedIndex == index {
            lblText.textColor = answerChoice.isRightAnswer ? UIColor.green : UIColor.red
            lblText.font = UIFont.boldSystemFont(ofSize: lblText.font.pointSize)
            lblIndex.backgroundColor = lblText.textColor
        }
        self.lblText?.text =  answerChoice.answerText
    }
}

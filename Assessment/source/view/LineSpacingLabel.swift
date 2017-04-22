//
//  LineSpacingLabel.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit

class LineSpacingLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.text = ""
    }
    private func refreshText(){
        self.text = self.attributedText?.string
    }
    override var text: String?{
        set(newText){
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            let attributedText = NSAttributedString(string: newText ?? "", attributes: [NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle])
            print(self.attributedText ?? "")
            self.attributedText = attributedText
        }
        get{
           return super.attributedText?.string
        }
    }
    override var textColor: UIColor!{
        set(newColor){
            super.textColor = newColor
            refreshText()
        }
        get{
            return super.textColor
        }
    }
    override var font: UIFont!{
        set(newFont){
            super.font = newFont
            refreshText()
        }
        get{
            return super.font
        }
    }
}

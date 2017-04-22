//
//  Answer.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import Foundation
enum AnswerResult:Int{
    case correct = 0
    case wrong
    case skip
    func getString() -> String {
        switch self {
        case .correct:
            return "correct"
        case .wrong:
            return "wrong"
        case .skip:
            return "skip"
        }
    }
}
struct Answer{
    let assessmentID: String
    let answerResult: AnswerResult
    let timeTaken: Int
    func getXMLElement() -> AEXMLElement {
        let item = AEXMLElement.init(name: "item")
        let map = AEXMLElement.init(name: "map", value: nil, attributes: ["assessmentID":assessmentID,"timeTaken":"\(timeTaken)"])
        return item.addChild(map)
        
    }
}

//
//  Question.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import Foundation
struct AnswerChoice{
    let answerText: String
    let isRightAnswer : Bool
    
}
struct Question {
    let answerChoices: [AnswerChoice]
    let explanation: String
    let question: String
    let questionType: String
    let correctAnswer: String
    let assessmentID: String
    //Creating a Question from XML Element
    static func initWithElement(_ node: AEXMLElement) throws-> Question {
        var arrayAnswerChoices = [AnswerChoice]()
        let correctAnswer = node["correctAnswer"].value!
        for answerChoice in node["answerChoice"]["list"].children {
            let answerText = answerChoice.value!
            arrayAnswerChoices.append(AnswerChoice(answerText: answerText, isRightAnswer: correctAnswer == answerText))
        }
        return Question(
            answerChoices: arrayAnswerChoices,
            explanation: node["explanation"].value!,
            question: node["question"].value!,
            questionType: node["questionType"].value!,
            correctAnswer: node["correctAnswer"].value!,
            assessmentID: node["assessmentID"].value!
        )
    }
    //Creating array of Questions from Root Response
    static func getAllQuestions(FromResponse root:AEXMLElement) throws -> [Question]{
        print("XML String",root.xml)
        
        var arrayQuestions = [Question]()
        for question in root["map"]["data"]["list"].children {
            arrayQuestions.append(try Question.initWithElement(question["map"]))
        }
        return arrayQuestions
    }
}


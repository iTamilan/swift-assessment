//
//  Assessment.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import Foundation
struct Assessment {
    var questions:[Question]
    var questionNo:Int = 0
    private var correctAnswers = [Answer]()
    private var wrongAnswers = [Answer]()
    private var skippedAnswers = [Answer]()
    private var totalTimeTaken = 0
    init?(questions: [Question]){
        self.questions = questions
    }
    //Generating XML ELEMENT from
    func getXMLElement()->AEXMLElement{
        let map = AEXMLElement.init(name: "map")
        //Creating Correct Answers List
        var correct = AEXMLElement.init(name: AnswerResult.correct.getString())
        addListXMLElement(fromAnswers: correctAnswers, parent: &correct)
        //Creating Wrong Answers List
        var wrong = AEXMLElement.init(name: AnswerResult.wrong.getString())
        addListXMLElement(fromAnswers: wrongAnswers, parent: &wrong)
        //Creating Skip Answers List
        var skip = AEXMLElement.init(name: AnswerResult.skip.getString())
        addListXMLElement(fromAnswers: skippedAnswers, parent: &skip)
        //Adding Childs to map
        map.addChild(correct)
        map.addChild(wrong)
        map.addChild(skip)
        return map
    }
    func addListXMLElement(fromAnswers:[Answer], parent:inout AEXMLElement){
        for answer in fromAnswers{
            parent.addChild(answer.getXMLElement())
        }
    }
    mutating func addAnswer(answer:Answer){
        questionNo += 1
        totalTimeTaken += answer.timeTaken
        switch answer.answerResult {
        case .correct:
            correctAnswers.append(answer)
        case .wrong:
            wrongAnswers.append(answer)
        case .skip:
            skippedAnswers.append(answer)
        }
    }
    //MARK: Assessment Summary
    func getSummaryDetail(indexes:(section:Int,row:Int)) -> (title:String,detail:String) {
        switch indexes {
        case (0,-1):
            return ("Answers of \(questions.count) Questions","")
        case (0,0):
            return ("Correct",String(correctAnswers.count))
        case (0,1):
            return ("Wrong",String(wrongAnswers.count))
        case (0,2):
            return ("Skipped",String(skippedAnswers.count))
        case (0,3):
            return ("Percentage",String(100.0*Double(correctAnswers.count)/Double(questions.count))+"%")
        case (1,-1):
            return ("Time Taken","")
        case (1,0):
            return ("Total Time (mm:ss)",CommonFunctions.getStringInMMSS(timeInterval: TimeInterval(totalTimeTaken)))
        case (1,1):
            return ("Average Time in seconds",String(TimeInterval(Double(totalTimeTaken)/Double(questions.count))))
        default:
            return ("","")
            
        }
    }
    //Fetching Assessment
    static func getAssessment(completionHandler:@escaping (Assessment?,String?)-> Void){
        getAssessmentFromStringFile(completionHandler: completionHandler)
        /*
         //For implemation purpose stored the result
         /*
         #if DEBUG
         let storedXMLString = UserDefaults.standard.string(forKey: "xmlString")
         guard storedXMLString == nil else {
         do{
         let questions: [Question] = try Question.getAllQuestions(FromResponse: try AEXMLDocument(xml: storedXMLString!))
         print(questions)
         print("\n\n\n")
         let assessment = Assessment.init(questions: questions)
         completionHandler(assessment,nil)
         }
         catch {
         completionHandler(nil,error.localizedDescription)
         }
         return
         }
         #endif
         */
         
         APIClient.getAssessment{ status, xmlString, error in
         guard status == true else{
         completionHandler(nil, error?.localizedDescription ?? "Server might me down. Pls try after sometime.")
         
         return
         }
         do{
         //                UserDefaults.standard.setValue(xmlString, forKey: "xmlString")
         let questions: [Question] = try Question.getAllQuestions(FromResponse: try AEXMLDocument(xml: xmlString!))
         print(questions)
         print("\n\n\n")
         let assessment = Assessment.init(questions: questions)
         completionHandler(assessment,nil)
         }
         catch {
         completionHandler(nil,error.localizedDescription)
         }
         }
         */
    }
    static func getAssessmentFromStringFile(completionHandler:@escaping (Assessment?,String?)-> Void){
        // Override point for customization after application launch.
        if let filepath = Bundle.main.path(forResource: "SampleAssesment", ofType: "txt") {
            do {
                let xmlString = try String(contentsOfFile: filepath)
                let questions: [Question] = try Question.getAllQuestions(FromResponse: try AEXMLDocument(xml: xmlString))
                print(questions)
                print("\n\n\n")
                let assessment = Assessment.init(questions: questions)
                completionHandler(assessment,.none)
            } catch {
                // contents could not be loaded
                completionHandler(.none,error.localizedDescription)
            }
        } else {
            // SampleAssesment.txt not found!
            completionHandler(.none,"Text file not found")
        }
    }
    func submitAssessment(completionHandler:@escaping (String?,String?)-> Void){
        APIClient.submitAssessment(xmlString: getXMLElement().xml, completionHandler: { (status, xmlString, error) in
            guard status == true else{
                completionHandler(nil, error?.localizedDescription ?? "Server might me down. Pls try after sometime.")
                
                return
            }
            do{
                let reponseXML = try AEXMLDocument(xml: xmlString!)
                completionHandler(reponseXML["status"].value!,nil)
            }
            catch {
                completionHandler(nil,error.localizedDescription)
            }
        })
    }
}

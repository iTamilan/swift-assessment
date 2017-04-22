//
//  AskQuestionViewController.swift
//  Assessment
//
//  Created by Tamilarasu on 13/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit
import AudioToolbox
let SystemSoundId:UInt32 = 1103
let kDefaultTintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
class AskQuestionViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var assessment:Assessment! = nil
    var question: Question! = nil
    private var selectedIdx = -1
    @IBOutlet weak var timerBarButtonItem: TimerBarButtonItem!
    @IBOutlet weak var skipBarBtnItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Load question
        question = assessment.questions[assessment.questionNo]
        //Configure Navigation Items
        configureNavigationItems()
        //Start the Timer
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timerBarButtonItem.startTimer()
    }
    //MARK: Configure
    func configureNavigationItems(){
        //set the titile
        self.title = "Question \(assessment.questionNo+1) of \(assessment.questions.count)"
    }
    //MARK: Actions
    @IBAction func actoinBarBtnSkipTapped(_ sender: UIBarButtonItem) {
        if selectedIdx == -1 {
            answerSelected(answerResult: .skip)
        }
        if assessment.questionNo == assessment.questions.count {
            self.performSegue(withIdentifier: "submitSegue", sender: self)
        }
        else{
            //Getting Viewcontroller fom Storyboard
            let askQuestionVC: AskQuestionViewController = self.storyboard!.instantiateViewController(withIdentifier: String(describing: AskQuestionViewController.self)) as! AskQuestionViewController
            askQuestionVC.assessment = assessment
            self.navigationController?.pushViewController(askQuestionVC, animated: true)
        }
    }
    //MARK: Answer selected
    func answerSelected(){
        let answerResult:AnswerResult = question.answerChoices[selectedIdx].isRightAnswer ? .correct : .wrong
        answerSelected(answerResult: answerResult)
        skipBarBtnItem.title = "NEXT"
        skipBarBtnItem.tintColor = kDefaultTintColor
        let timeInterval = TimeInterval(question.explanation.characters.count/(answerResult == AnswerResult.correct ? 7 : 10 ))
        animateProgressBar(timeInterval: timeInterval)
    }
    func answerSelected(answerResult:AnswerResult){
        timerBarButtonItem.stopTimer()
        assessment.addAnswer(answer: Answer(assessmentID: question.assessmentID, answerResult: answerResult, timeTaken: timerBarButtonItem.timeTakenInSec))

    }
    // MARK: - Animating Progress Bar
    func animateProgressBar(timeInterval:TimeInterval){
        UIView.animate(withDuration: timeInterval, animations: {
            self.progressView.setProgress(1.0, animated: false)
            self.progressView.layoutIfNeeded()
        }) { (completed) in
            if completed {
                self.actoinBarBtnSkipTapped(self.skipBarBtnItem)
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is SubmitViewController {
            let submitVC: SubmitViewController = segue.destination as! SubmitViewController
            submitVC.assessment = assessment
        }
    }
    //MARK: Tableview
    //MARK: - UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return question.answerChoices.count
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  (question == nil) ? 0 : 2+(selectedIdx > -1 ? 1:0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let questionCell:QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier:String(describing: QuestionTableViewCell.self)) as! QuestionTableViewCell
            questionCell.configure(question: question)
            return questionCell
        case 1:
            let answerChoiceCell:AnswerChoiceTableViewCell = tableView.dequeueReusableCell(withIdentifier:String(describing: AnswerChoiceTableViewCell.self)) as! AnswerChoiceTableViewCell
            answerChoiceCell.configure(question:question,index: indexPath.row,selectedIndex:selectedIdx)
            return answerChoiceCell
        default:
            let explanationCell:ExplanationTableViewCell = tableView.dequeueReusableCell(withIdentifier:String(describing: ExplanationTableViewCell.self)) as! ExplanationTableViewCell
            explanationCell.configure(question: question)
            return explanationCell
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isHighlighted = false
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Question"
        case 1:
            return "Choose an answer"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return (indexPath.section != 1 || selectedIdx > -1) ? nil : indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        AudioServicesPlaySystemSound(question.answerChoices[selectedIdx].isRightAnswer ? SystemSoundId : kSystemSoundID_Vibrate);
        tableView.insertSections([2], with: .fade)
        tableView.reloadSections([1], with: .fade)
        answerSelected()
    }
}

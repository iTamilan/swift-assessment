//
//  ViewController.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit
class StartViewController: UIViewController {
    
    var assessment:Assessment?
    //MARK: View Outlets
    @IBOutlet weak var btnRetry : UIButton!
    @IBOutlet weak var lblTotalQuestions: UILabel!
    @IBOutlet weak var viewStart: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAssessment()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchAssessment(){
        //Fetch questions
        IndicatorView.addIndicatore(toView: self.view, withMessage: "fetching...")
        
        Assessment.getAssessment { (assessment, error) in
            IndicatorView.removeIndicatore(fromView: self.view)
            guard assessment != nil else{
                UIAlertController.showError(errorMessage: error, viewController: self)
                DispatchQueue.main.async {
                    self.btnRetry.isHidden = false
                }
                return;
            }
            DispatchQueue.main.async {
                self.lblTotalQuestions.text = "TOTAL QUESTIONS : \(assessment?.questions.count ?? 0)"
                self.viewStart.isHidden = false
            }
            self.assessment = assessment
        }
    }
    //MARK: Button Actions
    
    @IBAction func actionBtnRetry(_ sender: Any) {
        btnRetry.isHidden = true
        fetchAssessment()
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AskQuestionViewController {
            let askQuestionVC: AskQuestionViewController = segue.destination as! AskQuestionViewController
            askQuestionVC.assessment = assessment
        }
    }
}



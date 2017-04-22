//
//  SubmitViewController.swift
//  Assessment
//
//  Created by Tamilarasu on 13/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit
enum SubmitState:Int{
    case submitting = 0
    case success
    case failed
}
class SubmitViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var assessment:Assessment! = nil
    var submittedState = SubmitState.submitting
    @IBOutlet var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Summary"
        submitAssessment()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func submitAssessment(){
        //Submitting answers
        self.submittedState = .success
        self.tableView?.insertSections([2], with: .fade)
        /*
         IndicatorView.addIndicatore(toView: self.view, withMessage: "submitting...")
         assessment.submitAssessment { (successMessage, errorMessage) in
         IndicatorView.removeIndicatore(fromView: self.view)
         guard successMessage != nil else{
         UIAlertController.showError(errorMessage: errorMessage, viewController: self)
         if self.submittedState != .failed {
         DispatchQueue.main.async {
         self.submittedState = .failed
         self.tableView?.insertSections([2], with: .fade)
         }
         }
         return;
         }
         DispatchQueue.main.async {
         self.submittedState = .success
         self.tableView?.insertSections([2], with: .fade)
         }
         //            UIAlertController.showAlert(title: "Success!", message: "Your assessment submitted successfully", viewController: self)
         }
         */
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2+(self.submittedState != .submitting ? 1 : 0)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0...1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell")
            let details = assessment.getSummaryDetail(indexes: (indexPath.section,indexPath.row))
            cell?.textLabel?.text = details.title
            cell?.detailTextLabel?.text = details.detail
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell")
            cell?.textLabel?.textAlignment = NSTextAlignment.center
            cell?.textLabel?.textColor = kDefaultTintColor
            cell?.textLabel?.text = submittedState == .success ? "START AGAIN": "RETRY"
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if submittedState == .success {
            self.performSegue(withIdentifier: "startAgainSegue", sender: self)
        } else {
            submitAssessment()
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 2 ? indexPath : nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return assessment.getSummaryDetail(indexes: (section,-1)).title
    }
    
}

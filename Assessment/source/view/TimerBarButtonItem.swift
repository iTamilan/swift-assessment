//
//  TimerBarButtonItem.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit
class TimerBarButtonItem: UIBarButtonItem {
    private(set) var timeTakenInSec = 0
    private var timer : Timer!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeTimer()
    }
    func initializeTimer(){
        //Configure Data formatter
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (repestsTimer) in
            
            if repestsTimer.isValid {
                self.timeTakenInSec += 1
                DispatchQueue.main.async{
                    self.title = CommonFunctions.getStringInMMSS(timeInterval: TimeInterval(self.timeTakenInSec))
                }
            }
        }
    }
    //Start the timer
    public func startTimer(){
        timer.fire()
    }
    public func stopTimer(){
        timer.invalidate()
        self.isEnabled = false
    }
}

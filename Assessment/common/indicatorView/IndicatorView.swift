//
//  IndicatorView.swift
//  Assessment
//
//  Created by Tamilarasu on 12/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    @IBOutlet weak var lblMessage: UILabel!

    //Public Statis Methods
    public static func addIndicatore(toView view:UIView?,withMessage message:String){
        guard view != nil else {
            print("No super view to add the indicator view")
            return
        }
        DispatchQueue.main.async {
            let indicatoreView : IndicatorView = Bundle.main.loadNibNamed(String(describing: IndicatorView.self), owner: view, options: nil)?.first as! IndicatorView
            indicatoreView.lblMessage.text = message
            indicatoreView.frame = (view?.bounds)!
            view?.addSubview(indicatoreView)
        }
    }
    public static func removeIndicatore(fromView view:UIView?){
        DispatchQueue.main.async {
            guard view != nil else {
                print("No super view to remove the indicatore view")
                return
            }
            for subView in (view?.subviews)!{
                if subView is IndicatorView{
                    
                    subView.removeFromSuperview()
                }
            }
        }
    }
}

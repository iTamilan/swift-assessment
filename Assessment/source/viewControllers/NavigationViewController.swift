//
//  NavigationViewController.swift
//  Assessment
//
//  Created by Tamilarasu on 13/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: UINavigationViewController Delegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //For holding only one viewcontroller in navigation controller stack
        if navigationController.viewControllers.count>1 {
            navigationController.setViewControllers([navigationController.viewControllers.last!], animated: false)
        }
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //Hides the backbutton
        viewController.navigationItem.setHidesBackButton(true, animated: false)
    }
    
}

//
//  UIAlertController+Simple.swift
//  Assessment
//
//  Created by Tamilarasu on 14/04/2017.
//  Copyright © 2017 iTamilan. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
    static func showError(errorMessage:String?,viewController:UIViewController?){
        showAlert(title: "Error !", message: errorMessage, viewController: viewController)
    }
    static func showAlert(title: String?,message: String?,viewController:UIViewController?){
        let alertController = UIAlertController.init(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

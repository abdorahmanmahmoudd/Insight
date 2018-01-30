//
//  GeneralMethods.swift
//  MedicalDoctor
//
//  Created by abdelrahman.youssef on 1/21/18.
//  Copyright © 2018 HyperDesign. All rights reserved.
//

import UIKit

func showAlert(title:String, message:String, vc:UIViewController, closure:(()->())?)
{
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
    { (result : UIAlertAction) -> Void in
        closure?()
    }
    alertController.addAction(okAction)
    vc.present(alertController, animated: true, completion: nil)
}

func showYesNoAlert(title:String, message:String, vc:UIViewController, closure:((Bool)->())?)
{
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
    { (result : UIAlertAction) -> Void in
        closure?(true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
    { (result : UIAlertAction) -> Void in
        closure?(false)
    }
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    vc.present(alertController, animated: true, completion: nil)
}

func showYesNoAlert(title:String, message:String, vc:UIViewController, firstBtnTitle:String, secondBtnTitle:String,  closure:((Bool)->())?)
{
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: firstBtnTitle, style: UIAlertActionStyle.default)
    { (result : UIAlertAction) -> Void in
        closure?(true)
    }
    let cancelAction = UIAlertAction(title: secondBtnTitle, style: UIAlertActionStyle.default)
    { (result : UIAlertAction) -> Void in
        closure?(false)
    }
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    vc.present(alertController, animated: true, completion: nil)
}

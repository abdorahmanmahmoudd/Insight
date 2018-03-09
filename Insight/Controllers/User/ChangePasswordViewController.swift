//
//  ChangePasswordViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ChangePasswordViewController: ParentViewController {
    
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tfCurrentPass: UITextField!
    @IBOutlet var tfNewPass: UITextField!
    @IBOutlet var tfConfirmPass: UITextField!
    
    var isKeyboard = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
        setStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if !isKeyboard {
//                self.view.frame.size.height -= keyboardSize.height
//                isKeyboard = !isKeyboard
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if isKeyboard{
//                self.view.frame.size.height += keyboardSize.height
//                isKeyboard = !isKeyboard
//            }
//        }
//    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setStyle(){
        
        self.title = "Change password"
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if dataIsValid(){
            
            save()
        }
        
    }
    
    func dataIsValid() -> Bool{
        
        var isValid = true
        
        if tfCurrentPass.text != nil && tfCurrentPass.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter current password", vc: self, closure: nil)
            
        }else if tfNewPass.text != nil && tfNewPass.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter new password", vc: self, closure: nil)
            
        }else if tfConfirmPass.text != nil && tfConfirmPass.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please confirm the password", vc: self, closure: nil)
            
        }else if tfConfirmPass.text != tfNewPass.text {
            
            isValid = false
            showAlert(title: "", message: "Confirmed password and new password are not matched", vc: self, closure: nil)
            
        }
        
        
        return isValid
    }
    
    func save(){
        btnSave.isEnabled = false
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        um.changePassword(current: tfCurrentPass.text!, new: tfNewPass.text!, complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSave.isEnabled = true
            
            if let statusCode = code as? Int {
                
                if statusCode == 200 {
                    
                    if let obj = json {
                        
                        if obj.isSuccess == true{
                            
                            showAlert(title: "", message: "Password changed successfully", vc: self, closure:{
                                
                                self.navigationController?.popViewController(animated: true)
                            })
                        }else{
                            
                            showAlert(title: "", message: obj.message, vc: self, closure: nil)
                        }
                    }
                    
                }else if statusCode == 452 {//token expired
                    
                    // TODO: call refresh token API
                    showAlert(title: "", message: "Token expired", vc: self, closure: nil)
                    
                }else if statusCode == 456{
                    
                    showAlert(title: "", message: "User account is blocked", vc: self, closure: nil)
                    
                }else if statusCode == 451{ //force update
                    
                    // TODO: update the app
                    showAlert(title: "", message: "Update the application", vc: self, closure: nil)
                    
                }else {
                    
                    showAlert(title: "", message: "Error code \(statusCode)", vc: self, closure: nil)
                }
                
            }
            
            
        }) { (error, msg) in
            
            self.btnSave.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Check your internet connection", vc: self, closure: nil)
            
        }
    }

}

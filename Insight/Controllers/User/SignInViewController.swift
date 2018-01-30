//
//  SignInViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/30/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var btnForgetPass: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var txtFieldPass: UITextField!
    @IBOutlet var txtFieldPhone: UITextField!
    
    var isKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !isKeyboard {
                self.view.frame.size.height -= keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyboard{
                self.view.frame.size.height += keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func btnForgetClicked(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        
        if dataIsValid(){
            
            signIn()
        }
    }

    func dataIsValid() -> Bool{
        
        var isValid = true
        
        if txtFieldPhone.text != nil && txtFieldPhone.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter phone number", vc: self, closure: nil)
            
        }else if !txtFieldPhone.text!.isValidPhone() {
            
            isValid = false
            showAlert(title: "", message: "Phone number must be 11 digits", vc: self, closure: nil)
            
        }else if txtFieldPass.text != nil && txtFieldPass.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter password", vc: self, closure: nil)
            
        }
        
        return isValid
    }

    func signIn(){
        
        btnSignIn.isEnabled = false
        btnForgetPass.isEnabled = false
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        um.SignIn(phone: txtFieldPhone.text!, pass: txtFieldPass.text!, complation: { (json, data) in
            
            hideLoaderFor(view: self.view)
            self.btnSignIn.isEnabled = true
            self.btnForgetPass.isEnabled = true
            
            if let obj = json {
                
                if obj.user != nil && obj.token != nil{
                    
                    UserModel.getInstance.saveUser(obj)
                    
                }else if let errs = data as? [String:Any] {
                    
                    if let err =  errs["error"] {
                        
                        showAlert(title: "", message: "\(err)"  , vc: self, closure: nil)
                    }
                }
                
            }
            
        }) { (error, msg) in
            
            self.btnSignIn.isEnabled = true
            self.btnForgetPass.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to sign in", vc: self, closure: nil)

        }
    }
}

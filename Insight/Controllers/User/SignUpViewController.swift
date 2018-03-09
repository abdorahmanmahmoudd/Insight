//
//  SignUpViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/30/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SignUpViewController: ParentViewController {

    @IBOutlet var btnHaveAccount: UIButton!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfSchool: UITextField!
    @IBOutlet var tfGovern: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfConfirmPass: UITextField!
    @IBOutlet var tfPass: UITextField!
    @IBOutlet var tfName: UITextField!
    
    weak var delegate : AuthenticationViewController?
    
    var isKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        
        if dataIsValid(){
            
            signup()
        }
    }
    
    @IBAction func btnHaveAccountClicked(_ sender: UIButton) {
        
        if delegate != nil {
            
            delegate?.initSignInView()
        }
    }

    func dataIsValid() -> Bool{
        
        var isValid = true
        
        if tfName.text != nil && tfName.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter your name", vc: self, closure: nil)
            
        }else if tfPass.text != nil && tfPass.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter password", vc: self, closure: nil)
            
        }else if tfConfirmPass.text != nil && tfConfirmPass.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please confirm the password", vc: self, closure: nil)
            
        }else if tfPass.text != tfConfirmPass.text {
            
            isValid = false
            showAlert(title: "", message: "Confirmed password is incorrect", vc: self, closure: nil)
            
        }else if tfPhone.text != nil && tfPhone.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter phone number", vc: self, closure: nil)
            
        }else if !tfPhone.text!.isValidPhone() {
            
            isValid = false
            showAlert(title: "", message: "Phone number must be 11 digits", vc: self, closure: nil)
            
        }else if tfGovern.text != nil && tfGovern.text!.hasNoCharchters() {
            
            isValid = false
            showAlert(title: "", message: "Please enter your governorate", vc: self, closure: nil)
            
        }else if tfEmail.text != nil && tfEmail.text!.hasNoCharchters(){
            
            isValid = false
            showAlert(title: "", message: "Please enter your Email", vc: self, closure: nil)
            
        }else if !tfEmail.text!.isValidEmail(){
            
            isValid = false
            showAlert(title: "", message: "Invalid Email address", vc: self, closure: nil)
        }
        
        
        return isValid
    }
    
    func signup(){
        
        view.endEditing(true)
        btnSignUp.isEnabled = false
        btnHaveAccount.isEnabled = false
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        um.SignUp(name: tfName.text!, mobile: tfPhone.text!, pass: tfPass.text!, governorate: tfGovern.text!, school: tfSchool.text!, email: tfEmail.text!, complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSignUp.isEnabled = true
            self.btnHaveAccount.isEnabled = true
            
            if let statusCode = code as? Int {
                
                if statusCode == 201 { // registered successfully
                    
                    if let user = json{
                        
                        UserModel.getInstance.saveUser(user)
                        showAlert(title: "", message: "User registered successfully", vc: self, closure: {
                            
                            self.openHome()
                        })
                    }
                    
                }else if statusCode == 400{ // bad request
                    
                    showAlert(title: "", message: "Taken mobile number or email"  , vc: self, closure: nil)
                    
                }else { // unknown error
                    
                    showAlert(title: "", message: "Error code \(statusCode)"  , vc: self, closure: nil)
                }
            }
            
            
        }) { (error, msg) in
            
            self.btnSignUp.isEnabled = true
            self.btnHaveAccount.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to sign up \n please check your internet connection", vc: self, closure: nil)
            
        }
    }
    
    func openHome(){
        
        let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        
        if let vc = sb.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController{
            
            //            self.view.window?.rootViewController = vc
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}

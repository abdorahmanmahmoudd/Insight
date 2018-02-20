//
//  SignInViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/30/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class SignInViewController: ParentViewController {

    @IBOutlet var btnForgetPass: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var txtFieldPass: UITextField!
    @IBOutlet var txtFieldPhone: UITextField!
    
    var isKeyboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        um.SignIn(phone: txtFieldPhone.text!, pass: txtFieldPass.text!, complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSignIn.isEnabled = true
            self.btnForgetPass.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let user = json as? AuthRootClass{
                     
                        UserModel.getInstance.saveUser(user)
                        self.openHome()
                    }
                }else if statusCode == 401{ //unauthorized
                    
                    showAlert(title: "", message: "Invalid username or password", vc: self, closure: nil)
                }else{
                    
                    showAlert(title: "", message: "Error code \(statusCode)"  , vc: self, closure: nil)
                }
            }
            
            
        }) { (error, msg) in
            
            self.btnSignIn.isEnabled = true
            self.btnForgetPass.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to sign in \n Please check your internet connection", vc: self, closure: nil)

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

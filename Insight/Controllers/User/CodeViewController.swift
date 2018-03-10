//
//  CodeViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/10/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    @IBOutlet var btnDismiss: UIButton!
    @IBOutlet var tfCode: UITextField!
    @IBOutlet var btnValidate: UIButton!
    
    var email = String()
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    @IBAction func btnDismissClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func btnValidateClicked(_ sender: UIButton) {
        
        if tfCode.text != nil && !tfCode.text!.hasNoCharchters(){
            
            validateCode(email: email, code: tfCode.text!)
        }
    }
    
    func validateCode(email: String, code: String){
        
        showLoaderFor(view: self.view)
        btnValidate.isEnabled = false
        btnDismiss.isEnabled = false
        
        let sm = ServerManager()
        sm.httpConnect(with: PassConfirmationCodeURL, method: .post, paramters: ["email": email, "code": code], authentication: nil , AdditionalHeaders: ["version" : appVersion], complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnValidate.isEnabled = true
            self.btnDismiss.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let obj = json as? [String: Any]{
                        
                        if let isSuccess = obj["isSuccess"] as? Bool{
                            
                            if isSuccess{
                                
                                self.performSegue(withIdentifier: "ResetPassSegue", sender: self)
                                
                            }else{
                                let msg = obj["message"] as? String ?? "Something went wrong"
                                showAlert(title: "", message: msg, vc: self, closure: nil)
                            }
                            
                        }else if let msg = obj["message"] as? String{
                            
                            showAlert(title: "", message: msg, vc: self, closure: nil)
                        }
                    }else{
                        
                        showAlert(title: "", message: "Something went wrong", vc: self, closure: nil)
                    }
                    
                }else{
                    
                    showAlert(title: "", message: "Something went wrong", vc: self, closure: nil)
                }
            }
            
        }) { (error, msg) in
            
            self.btnDismiss.isEnabled = true
            hideLoaderFor(view: self.view)
            self.btnValidate.isEnabled = true
            showAlert(title: "", message: "Failed to validate code.\n Please check your internet connection", vc: self, closure: nil)
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResetPassSegue"{
            
            if let des = segue.destination as? UpdatePassViewController{
                
                des.email = email
            }
        }
    }

}

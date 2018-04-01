//
//  UpdatePassViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/10/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class UpdatePassViewController: UIViewController {
    
    @IBOutlet var btnDismiss: UIButton!
    @IBOutlet var tfNewPass: UITextField!
    @IBOutlet var btnSubmit : UIButton!
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func btnDismissClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissView (_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton){
        
        if tfNewPass.text != nil && !tfNewPass.text!.hasNoCharchters(){
            
                resetPass(email: email, newPass: tfNewPass.text!)
        }
    }

    func resetPass(email: String, newPass: String){
        
        showLoaderFor(view: self.view)
        btnSubmit.isEnabled = false
        btnDismiss.isEnabled = false
        
        let sm = ServerManager()
        sm.httpConnect(with: UpdatePassURL, method: .put, paramters: ["email": email, "newPassword": newPass], authentication: nil , AdditionalHeaders: ["version" : appVersion], complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnSubmit.isEnabled = true
            self.btnDismiss.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let obj = json as? [String: Any]{
                        
                        if let isSuccess = obj["isSuccess"] as? Bool{
                            
                            if isSuccess{
                                
                                showAlert(title: "", message: "Password changed successfully", vc: self, closure: {
                                    self.dismiss(animated: true, completion:nil)
                                })
                                
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
            self.btnSubmit.isEnabled = true
            showAlert(title: "", message: "Failed to reset password.\n Please check your internet connection", vc: self, closure: nil)
        }
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

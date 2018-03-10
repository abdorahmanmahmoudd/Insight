//
//  ForgetPasswordViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/30/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: ParentViewController {

    @IBOutlet var viewDismissing: UIView!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var tfEmail: UITextField!
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissView (_:)))
        self.viewDismissing.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissView (_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        
        if tfEmail.text != nil && tfEmail.text!.isValidEmail(){
            forgetPass(email: tfEmail.text!)
        }
    }

    func forgetPass(email : String){
        
        showLoaderFor(view: self.view)
        self.btnSend.isEnabled = false
        tfEmail.isUserInteractionEnabled = false
        
        let sm = ServerManager()
        sm.httpConnect(with: ForgetPassURL, method: .post, paramters: ["email": email], authentication: nil, AdditionalHeaders: ["version": appVersion], complation:
            { (json, code) in
                
                hideLoaderFor(view: self.view)
                self.btnSend.isEnabled = true
                self.tfEmail.isUserInteractionEnabled = true
                
                if let obj = json as? [String: Any], let _ = code{
                    
                    if let success = obj["isSuccess"] as? Bool{
                        
                        if success{
                            
                            showAlert(title: "", message: "You will recieve a code.", vc: self, closure: {
                                self.performSegue(withIdentifier: "CodeSegue", sender: self)
                            })
                            
                        }else{
                            showAlert(title: "", message: "Can not send your request right now.\nPlease try again later.", vc: self, closure: nil)
                        }
                        
                    }else if let msg = obj["message"] as? String{
                        
                        showAlert(title: "", message: msg, vc: self, closure: nil)
                    }
                }else{
                    showAlert(title: "", message: "Something went wrong.", vc: self, closure: nil)
                }
        })
        { (error, msg) in
            
            hideLoaderFor(view: self.view)
            self.tfEmail.isUserInteractionEnabled = true
            self.btnSend.isEnabled = true
            showAlert(title: "", message: "Failed to send request\n Please check your internet connection.", vc: self, closure: nil)
        }
    }
    @IBAction func dismissKeyboardViewTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CodeSegue"{
            
            if let des = segue.destination as? CodeViewController{
                
                des.email = tfEmail.text!
            }
        }
    }
    
}

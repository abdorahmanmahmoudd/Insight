//
//  ForgetPasswordViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/30/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

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
        
    }

    func forgetPass(){
        
        let um = UserModel()
        
        um.ForgetPassword(email: tfEmail.text!, complation: { (json, data) in
            
            
            
        }) { (error, msg) in
            
            
        }
    }
    
}

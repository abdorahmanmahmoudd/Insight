//
//  LogoutViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class LogoutViewController: ParentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("did load")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        
        um.LogOut(complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let object = json{
                        
                        if object.isSuccess {
                            
                            UserModel.getInstance.deleteUserCredentials()
                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        }
                        else{
                            
                            showAlert(title: "", message: "\(object.message ?? "")", vc: self, closure: nil)
                        }
                        
                    }
                    
                }else if statusCode == 452{ //token expired
                    
                    showAlert(title: "", message: "Token expired", vc: self, closure: nil)
                    
                }else if statusCode == 456{ //account blocked
                    
                    showAlert(title: "", message: "Accout blocked", vc: self, closure: nil)
                    
                }else if statusCode == 451{ //force update
                    
                    showAlert(title: "", message: "Please update", vc: self, closure: nil)
                    
                }else{
                    
                    showAlert(title: "", message: "Error code \(statusCode)"  , vc: self, closure: nil)
                }
            }
            
        }) { (error, msg) in
            
            hideLoaderFor(view: self.view)
            showAlert(title: "Error", message: "Failed to log out \n Please check your internet connection", vc: self, closure: nil)
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

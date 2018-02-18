//
//  LaunchScreenViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 1/29/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class LandViewController: ParentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthenticatedUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAuthenticatedUser(){
        
        if let _ = UserModel.getInstance.getUser() {
            
//            signIn(mobile: userObj.user.mobile, pass: userObj.user.)
            openHome()
            
        }else {
            
            openLoginVC()
        }
    }
    
    func openLoginVC(){
        
        let sb = UIStoryboard.init(name: "Authentication", bundle: Bundle.main)
        
        if let vc = sb.instantiateViewController(withIdentifier: "AuthVC") as? AuthenticationViewController{
            
//            self.view.window?.rootViewController = vc
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func openHome(){
        
        let sb = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        
        if let vc = sb.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController{
            
            //            self.view.window?.rootViewController = vc
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    func signIn(mobile: String, pass:String){
        
        showLoaderFor(view: self.view)
        
        let um = UserModel()
        um.SignIn(phone: mobile, pass: pass, complation: { (json, data) in
            
            hideLoaderFor(view: self.view)
            
            if let obj = json {
                
                if obj.user != nil && obj.token != nil{
                    
                    UserModel.getInstance.saveUser(obj)
                    
//                    openHome()
                    
                }else if let errs = data as? [String:Any] {
                    
                    if let err =  errs["error"] {
                        
                        showAlert(title: "", message: "\(err)"  , vc: self, closure: nil)
                    }
                }
                
            }
            
        }) { (error, msg) in

            hideLoaderFor(view: self.view)
            showAlert(title: "", message: "Failed to sign in", vc: self, closure: {
                
                self.openLoginVC()
                
            })
            
        }
    }

}

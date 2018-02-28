//
//  ResultsViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/23/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ResultsViewController: ParentViewController {

    @IBOutlet var viewAppAvgResults: UICircularProgressRingView!
    @IBOutlet var viewUserResults: UICircularProgressRingView!
    @IBOutlet var btnDone : UIButton!
    
    var userResult = CGFloat()
    var appAvg = CGFloat()
    var updateServer = false
    var categoryId = String()
    var subCategoryId = String()
    var subSubCategoryId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Results"
        viewUserResults.ringStyle = .inside
        viewAppAvgResults.ringStyle = .inside
        viewUserResults.font = getFont(25, MavenProMedium)
        viewAppAvgResults.font = getFont(25, MavenProMedium)
        
        if updateServer{
            
            self.sendScoreToServer()
            
        }else{
            
            selectedIndex = 5
            addSideMenuBtn()
            getScore()
        }
        
    }
    
    func startAnimation(){
        
        viewUserResults.setProgress(value: userResult, animationDuration: TimeInterval.init(2))
        viewAppAvgResults.setProgress(value: appAvg, animationDuration: TimeInterval.init(2))
    }
    
    @IBAction func btnDoneClicked(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func sendScoreToServer(){
        
        btnDone.isEnabled = false
        showLoaderFor(view: self.view)
        
        let sm = ScoreModel()
        sm.updateScore(score: userResult, category_id: categoryId, sub_category_id: subCategoryId, sub_sub_category_id: subSubCategoryId, complation: { (json, code) in
            
            hideLoaderFor(view: self.view)
            self.btnDone.isEnabled = true
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let object = json{
                        
                        if object.isSuccess && object.data.average != nil{
                            
                            self.appAvg = CGFloat.init(Float.init(object.data.average)!)
                            self.startAnimation()

                        }
                        else{
                            
                            showAlert(title: "", message: "Something went wrong", vc: self, closure: nil)
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
            
            self.btnDone.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "Error", message: "Failed to send user score \n Please check your internet connection", vc: self, closure: nil)
        }
    }
    
    func getScore(){
        
        btnDone.isEnabled = false
        showLoaderFor(view: self.view)
        
        let sm = ScoreModel()
        sm.getScore( complation: { (json, code) in
            
            self.btnDone.isEnabled = true
            hideLoaderFor(view: self.view)
            
            if let statusCode = code as? Int{
                
                if statusCode == 200{
                    
                    if let object = json{
                        // TODO: set values
                        self.startAnimation()
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
            
            self.btnDone.isEnabled = true
            hideLoaderFor(view: self.view)
            showAlert(title: "Error", message: "Failed to send user score \n Please check your internet connection", vc: self, closure: nil)
        }
    }
    

}

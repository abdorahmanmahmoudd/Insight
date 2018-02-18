//
//  ParentViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/18/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    var hud : MBProgressHUD! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configurations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurations(){
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
    }
    
//    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
//        view.endEditing(true)
//    }

    //MARK: - progress hud
    func showLoading()
    {
        self.view.backgroundColor = UIColor.white
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .indeterminate;
    }
    
    func hideLoading()
    {
        self.hud?.hide(animated: true)
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

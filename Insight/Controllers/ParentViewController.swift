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
    
    func addSideMenuBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "icDrawer"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func openSideMenu(){
        
        SideMenuManager.shared.show(from: self.navigationController!)
    }

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

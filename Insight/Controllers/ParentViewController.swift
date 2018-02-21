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
    
    @objc func openEditFlagVC(_ sender: flagBtn){
        
        let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
        if let vc = sb.instantiateViewController(withIdentifier: "EditFlagVC") as? EditFlagViewController{
            
            vc.flagValue = sender.flagValue
            vc.questionId = sender.questionId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
   

}

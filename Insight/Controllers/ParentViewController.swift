//
//  ParentViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/18/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import RealmSwift

class ParentViewController: UIViewController {
    
    var hud : MBProgressHUD! = nil
    var realm : Realm? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        realm = try! Realm()
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
        
        if sender.flagValue == 0{
            let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
            if let vc = sb.instantiateViewController(withIdentifier: "EditFlagVC") as? EditFlagViewController{
                
                vc.flagValue = sender.flagValue
                vc.questionId = sender.questionId
                vc.indexPath = sender.indexPath
                vc.notificationName = sender.notificationName
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            
            let alert = UIAlertController.init(title: nil, message: "Are you sure you want to remove this flagged question?", preferredStyle: .alert)
            alert.view.tintColor = #colorLiteral(red: 1, green: 0.7244103551, blue: 0.2923497558, alpha: 1)
            let yes = UIAlertAction.init(title: "YES", style: .default, handler: { (action) in
                //handle remove question
                self.deleteQuestionFlag(sender: sender)
            })
            let no = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
    func deleteQuestionFlag(sender button: flagBtn){
        button.flagValue = 0
        do {
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", button.questionId )
            
            if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first {
                
                try? realm?.write {
                    realm?.delete(fq)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: button.notificationName), object: nil, userInfo: ["indexPath":button.indexPath])
                print("\(String(describing: realm?.objects(FlaggedQuestion.self)))")
            }

            
        }catch let err {
            showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
   

}

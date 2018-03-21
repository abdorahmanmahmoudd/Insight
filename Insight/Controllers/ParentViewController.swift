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
    
    var realm : Realm? = nil
    
    static var currentQParentParentId : Int? // unit
    static var currentQParentId : Int? //section
    
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
    
    func resetToHome(){
        SideMenuManager.shared.reset()
    }

    //MARK: - progress hud
//    func showLoading()
//    {
//        self.view.backgroundColor = UIColor.white
//        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.mode = .indeterminate;
//    }
//    
//    func hideLoading()
//    {
//        self.hud?.hide(animated: true)
//    }
    
    @objc func openEditFlagVC(_ sender: flagBtn){
        
//        if selectedIndex == 0 {// 0 -> Home
        
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
                
                let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
                if let vc = sb.instantiateViewController(withIdentifier: "AddMediaVC") as? AddMediaViewController{
                    
                    vc.questionId = sender.questionId
                    vc.removeBtnHidden = false
                    vc.indexPath = sender.indexPath
                    vc.notificationName = sender.notificationName
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
//        }else if selectedIndex == 3{ //flagged screen
//
//            if sender.flagValue != 0{
//                let sb = UIStoryboard.init(name: "Flag", bundle: Bundle.main)
//                if let vc = sb.instantiateViewController(withIdentifier: "AddMediaVC") as? AddMediaViewController{
//
//                    vc.questionId = sender.questionId
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//        }
    
    }
//    
//    func deleteQuestionFlag(sender button: flagBtn){
//        button.flagValue = 0
//        do {
//            
//            let predicateQuery = NSPredicate.init(format: "Id == %@", button.questionId )
//            
//            if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first {
//                
//                try? realm?.write {
//                    realm?.delete(fq)
//                }
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: button.notificationName), object: nil, userInfo: ["indexPath":button.indexPath])
//                print("\(String(describing: realm?.objects(FlaggedQuestion.self)))")
//            }
//
//            
//        }catch let err {
//            showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
//        }
//    }
   

}

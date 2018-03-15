//
//  EditFlagViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/20/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import RealmSwift

class EditFlagViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var btnAddMedia: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var flagValue = 0
    var questionId = String()
    var indexPath = IndexPath()
    var notificationName = String()
    var flagSaved = false
    var flagSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
        print("\(realm!.objects(FlaggedQuestion.self))")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Flag"
        if let flagCellIndex = Flag(rawValue: flagValue)?.rawValue {
            
            tableView.selectRow(at: IndexPath(row: flagCellIndex - 1, section: 0), animated: true, scrollPosition: .none)
        }
        configureBackBtn()
    }
    
    func configureBackBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "back-NoShadow"), for: .normal)
        btn.setTitle("Back", for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func backBtnClicked(){
        
        if flagSaved{
            self.navigationController?.popViewController(animated: true)
        }else{
            showYesNoAlert(title: "Attention", message: "Do you want to exit without saving?", vc: self, firstBtnTitle: "Exit", secondBtnTitle: "Cancel", closure: { (exit) in
                if exit{
                    self.deleteFlaggedQuestion()
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }

    
    @IBAction func btnAddMediaClicked(_ sender: UIButton) {
        
        if flagSelected {
            performSegue(withIdentifier: "AddMediaSegue", sender: self)
        }else{
            showAlert(title: "", message: "Please choose flag to attach media", vc: self, closure: nil)
        }
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if flagSelected {
            flagSaved = true
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Flag.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditFlagCell", for: indexPath) as! EditFlagTableViewCell
        
        cell.lblFlag.text = Flag(rawValue: indexPath.row + 1)?.string
        cell.imgFlag.image = UIImage.init(named: Flag(rawValue: indexPath.row + 1)?.string ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        flagValue = Flag(rawValue: indexPath.row + 1)?.rawValue ?? 0
        saveQuestion()
    }
    
    func saveQuestion(){
    
        showLoaderFor(view: self.view)
        let q = FlaggedQuestion()
        q.flagValue = flagValue
        q.Id = questionId
        q.parentId = String(ParentViewController.currentQParentId ?? 0)
        q.parentParentId = String(ParentViewController.currentQParentParentId ?? 0)
        
        do {
            
            try realm?.write {
                realm?.add(q, update: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName ), object: nil, userInfo: ["indexPath":indexPath])
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFlagCounter" ), object: nil, userInfo:nil)
            self.flagSelected = true
            
        }catch let err {
            
            self.flagSelected = false
            showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
        }
        
        hideLoaderFor(view: self.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMediaSegue" {
            
            if let des = segue.destination as? AddMediaViewController{
                
                des.questionId = self.questionId
                des.removeBtnHidden = true
            }
        }
    }
    
    func deleteFlaggedQuestion(){
        
        do {
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
            
            if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                
                if fq.photoPath != nil {
                    
                    var imageFile: String {
                        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
                    }
                    let url = NSURL.init(fileURLWithPath: imageFile)
                    
                    if let filePath = url.appendingPathComponent(fq.photoPath!){
                        
                        if FileManager.default.fileExists(atPath: filePath.path) {
                            
                            try FileManager.default.removeItem(at: filePath)
                            
                        }
                    }
                }
                
                if fq.voiceNotePath != nil{
                    
                    var VoiceFile: String {
                        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
                    }
                    let url = NSURL.init(fileURLWithPath: VoiceFile)
                    
                    if let filePath = url.appendingPathComponent(fq.voiceNotePath!){
                        
                        if FileManager.default.fileExists(atPath: filePath.path) {
                            
                            try FileManager.default.removeItem(at: filePath)
                            
                        }
                    }
                }
                
                try realm?.write {
                    realm?.delete(fq)
                }
                
                print("\(realm!.objects(FlaggedQuestion.self))")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName ), object: nil, userInfo: ["indexPath":indexPath])
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFlagCounter" ), object: nil, userInfo:nil)
                
            }
            
        }catch let err{
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }


}

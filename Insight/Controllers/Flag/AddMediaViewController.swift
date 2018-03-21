//
//  AddMediaViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/24/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AddMediaViewController: ParentViewController {
    
    @IBOutlet var btnAddVoice: UIButton!
    @IBOutlet var btnAddNote: UIButton!
    @IBOutlet var btnAddPhoto: UIButton!
    @IBOutlet var btnRemoveFlaggedQuestion: UIButton!
    
    var removeBtnHidden = false
    var questionId = String()
    var indexPath = IndexPath()
    var notificationName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configuration(){
        
        self.title = "Add Media"
        btnRemoveFlaggedQuestion.isHidden = removeBtnHidden
        if !removeBtnHidden { // means that flagged questions selected
            
            btnAddNote.setTitle("Note", for: .normal)
            btnAddPhoto.setTitle("Photo", for: .normal)
            btnAddVoice.setTitle("Voice note", for: .normal)
        }
    }
    
    @IBAction func btnAddPhotoClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddPhotoSegue", sender: self)
    }
    @IBAction func btnAddNoteClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddNoteSegue", sender: self)
    }
    
    @IBAction func btnAddVoiceNoteClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "AddVoiceNoteSegue", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "AddPhotoSegue"{
            
            if let des = segue.destination as? AddPhotoViewController{
                
                des.questionId = self.questionId
            }
        }else if segue.identifier == "AddNoteSegue"{
            
            if let des = segue.destination as? AddNoteViewController{
                
                des.questionId = self.questionId
            }
        }else if segue.identifier == "AddVoiceNoteSegue"{
            
            if let des = segue.destination as? AddVoiceNoteViewController{
                
                des.questionId = self.questionId
            }
        }
    }

    @IBAction func btnRemoveFlaggedQuestionClicked(_ sender: UIButton) {
        
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
                
                self.navigationController?.popViewController(animated: true)
            }
            
        }catch let err{
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
}

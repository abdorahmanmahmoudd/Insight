//
//  AddNoteViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/25/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AddNoteViewController: ParentViewController, UITextViewDelegate {

    @IBOutlet var tvNote: BorderedTV!
    
    var questionId = String()
    var mediaSaved = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        self.title = "Add Note"
        tvNote.layer.borderColor = UIColor.white.cgColor
        getQuestionNoteIfExists()
        configureBackBtn()
    }
    
    func configureBackBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "back-NoShadow"), for: .normal)
        btn.setTitle(" Back", for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func backBtnClicked(){
        
        if mediaSaved{
            self.navigationController?.popViewController(animated: true)
        }else{
            showYesNoAlert(title: "Attention", message: "Unsaved changes will be discarded.", vc: self, firstBtnTitle: "Discard", secondBtnTitle: "Cancel", closure: { (exit) in
                if exit{
                    
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        do {
            
            if !tvNote.text.hasNoCharchters() {
                
                showLoaderFor(view: self.view)
                
                let text = tvNote.text
                
                let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
                
                if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                    
                    try realm?.write {
                        
                        question.note = text
                        
                        realm?.add(question, update: true)
                    }
                    mediaSaved = true
                }
                
                hideLoaderFor(view: self.view)
            }
            
        }catch let err{
            
            hideLoaderFor(view: self.view)
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
    
    func getQuestionNoteIfExists(){
        
        do {
            
            showLoaderFor(view: self.view)
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
            
            
            if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                
                if let note = question.note{
                    
                    self.tvNote.text = note
                }
            }
            hideLoaderFor(view: self.view)
            
        }catch let err{
            
            hideLoaderFor(view: self.view)
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        mediaSaved = false
    }

}

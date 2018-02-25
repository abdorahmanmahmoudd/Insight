//
//  AddNoteViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/25/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AddNoteViewController: ParentViewController {

    @IBOutlet var tvNote: BorderedTV!
    
    var questionId = String()
    
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
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        do {
            
            if tvNote.text.trimmedText().characters.count > 0 {
                
                showLoaderFor(view: self.view)
                
                let text = tvNote.text
                
                let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
                
                if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                    
                    try realm?.write {
                        
                        question.note = text
                        
                        realm?.add(question, update: true)
                    }
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

}

//
//  DerivativesViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/1/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class DerivativesViewController: ParentViewController, CorrectedQuestion, UITextViewDelegate {

    @IBOutlet var btnFlag: flagBtn!
    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tvAdjs: [UITextView]!
    @IBOutlet var tvVerbs: [UITextView]!
    @IBOutlet var tvNouns: [UITextView]!
    
    var questions : QuestionData?
    var showAnswers = false
    var isSubmitted = false
    weak var containerDelegate: QuestionsContainerViewController?
    
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
        
        if showAnswers{
            
            self.navigationController?.isNavigationBarHidden = false
            
        }
    }
    
    func configuration(){
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("DerivativesUpdateFlag"), object: nil)
        
        btnFlag.notificationName = "DerivativesUpdateFlag"
        btnFlag.defaultImage = #imageLiteral(resourceName: "flag-noBG")
        btnFlag.questionId = (questions?.id)!
        let predicateQuery = NSPredicate.init(format: "Id == %@", (questions?.id)!)
        if let fv = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first?.flagValue {
            
            btnFlag.flagValue = fv
        }
        if btnFlag.allTargets.count == 0{
            
            btnFlag.addTarget(self, action: #selector(self.openEditFlagVC(_:)), for: .touchUpInside)
        }
        fillData()
    }
    func fillData(){
        
        if questions != nil{
            
            for i in 0..<questions!.noun.count{
                
                if let noun = questions?.noun[i] ,  i < tvNouns.count{
                    
                    if showAnswers{
                        
                        tvNouns[i].attributedText = noun.content.html2AttributedString
                        tvNouns[i].isEditable = false
                        
                    }else{
                        
                        if questions?.noun[i].type == "question" {
                            
                            tvNouns[i].attributedText = noun.underLinedWord
                            
                        }else if questions?.noun[i].type == "answer"{
                            
                            tvNouns[i].isEditable = true
                            tvNouns[i].text = "....."
                        }
                    }
                }
            }
            
            for i in 0..<questions!.dVerb.count{
                
                if let verb = questions?.dVerb[i] ,  i < tvVerbs.count{
                    
                    if showAnswers{
                        
                        tvVerbs[i].attributedText = verb.content.html2AttributedString
                        tvVerbs[i].isEditable = false
                        
                    }else{
                     
                        if questions?.dVerb[i].type == "question" {
                            
                            tvVerbs[i].attributedText = verb.underLinedWord
                            
                        }else if questions?.dVerb[i].type == "answer"{
                            
                            tvVerbs[i].isEditable = true
                            tvVerbs[i].text = "....."
                        }
                        
                    }
                }
            }
            
            for i in 0..<questions!.adj.count{
                
                if let adj = questions?.adj[i] ,  i < tvAdjs.count{
                    
                    if showAnswers{
                        
                        tvAdjs[i].attributedText = adj.content.html2AttributedString
                        tvAdjs[i].isEditable = false
                        
                    }else{
                        
                        if questions?.adj[i].type == "question" {
                            
                            tvAdjs[i].attributedText = adj.underLinedWord
                            
                        }else if questions?.adj[i].type == "answer"{
                            
                            tvAdjs[i].isEditable = true
                            tvAdjs[i].text = "....."
                        }
                    }
                }
            }
        }else{
            
            showAlert(title: "", message: "Question Data not available!", vc: self, closure: {
                self.navigationController?.popViewController(animated: true )
            })
        }
    }
    
    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        if !self.isSubmitted{
            
            showYesNoAlert(title: "", message: "Do you want to submit your answers?", vc: self) { (submit) in
                if submit{
                    if self.containerDelegate != nil{
                        
                        self.containerDelegate?.submitQuestion()
                    }
                }else{
                    
                    if let nav = self.parent?.navigationController {
                        
                        if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionDerivativesVC") as? DerivativesViewController{
                            
                            selfVC.showAnswers = true
                            selfVC.questions = self.questions
                            nav.pushViewController(selfVC, animated: true)
                        }
                    }
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionDerivativesVC") as? DerivativesViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        let predicateQuery = NSPredicate.init(format: "Id == %@", btnFlag.questionId)
        
        if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first {
            print("\(fq)")
            btnFlag.flagValue = fq.flagValue
        }else {
            btnFlag.flagValue = 0
        }
    }
    
    func submitAnswers() {
        
        isSubmitted = true
        if questions != nil{
            
            for i in 0..<questions!.noun.count{
                
                if let noun = questions?.noun[i] ,  i < tvNouns.count{
                    
                    if questions?.noun[i].type == "question" {
                        
                        tvNouns[i].attributedText = noun.content.html2AttributedString
                        
                    }else if questions?.noun[i].type == "answer"{
                        
                        tvNouns[i].isEditable = false
                        if tvNouns[i].text.lowercased() == noun.underLinedWord?.string.lowercased(){
                            tvNouns[i].textColor = UIColor.green
                        }else{
                            tvNouns[i].textColor = UIColor.red
                        }
                    }
                }
            }
            
            for i in 0..<questions!.dVerb.count{
                
                if let verb = questions?.dVerb[i] ,  i < tvVerbs.count{
                    
                    if questions?.dVerb[i].type == "question" {
                        
                        tvVerbs[i].attributedText = verb.content.html2AttributedString
                        
                    }else if questions?.dVerb[i].type == "answer"{
                        
                        tvVerbs[i].isEditable = false
                        if tvVerbs[i].text.lowercased() == verb.underLinedWord?.string.lowercased(){
                            tvVerbs[i].textColor = UIColor.green
                        }else{
                            tvVerbs[i].textColor = UIColor.red
                        }
                    }
                }
            }
            
            for i in 0..<questions!.adj.count{
                
                if let adj = questions?.adj[i] ,  i < tvAdjs.count{
                    
                    if questions?.adj[i].type == "question" {
                        
                        tvAdjs[i].attributedText = adj.content.html2AttributedString
                        
                    }else if questions?.adj[i].type == "answer"{
                        
                        tvAdjs[i].isEditable = false
                        if tvAdjs[i].text.lowercased() == adj.underLinedWord?.string.lowercased(){
                            tvAdjs[i].textColor = UIColor.green
                        }else{
                            tvAdjs[i].textColor = UIColor.red
                        }
                    }
                }
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text.removeAll()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.characters.count == 0{
            textView.text = "....."
        }
    }
}

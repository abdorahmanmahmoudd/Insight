//
//  TrueFalseViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class TrueFalseViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource , UITextViewDelegate, CorrectedQuestion, AdvancedQuestion, UITextFieldDelegate{
    
    @IBOutlet var constraintHeightOfSearchView: NSLayoutConstraint!
    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    var showAnswers = false
    var isSubmitted = false
    weak var containerDelegate : QuestionsContainerViewController?
    var isSearch = false
    var tempQuestions = [QuestionData]()
    var searchTimer : Timer?
    
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
    
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        if isSearch{
            constraintHeightOfSearchView.constant = 46
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("TrueFalseUpdateFlag"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTrueFlaseCell", for: indexPath) as! TrueFalseTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvAnswer.isEditable = true
        
        cell.btnFlag.notificationName = "TrueFalseUpdateFlag"
        cell.btnFlag.indexPath = indexPath
        cell.btnFlag.defaultImage = #imageLiteral(resourceName: "flag-noBG")
        cell.btnFlag.questionId = questions[indexPath.row].id
        let predicateQuery = NSPredicate.init(format: "Id == %@", questions[indexPath.row].id)
        if let fv = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first?.flagValue {
            
            cell.btnFlag.flagValue = fv
        }
        if cell.btnFlag.allTargets.count == 0{
            
            cell.btnFlag.addTarget(self, action: #selector(self.openEditFlagVC(_:)), for: .touchUpInside)
        }
        
        if showAnswers{
            
            cell.tvAnswer.text = questions[indexPath.row].answerContent?.html2String
            cell.tvAnswer.isEditable = false
            if questions[indexPath.row].answer == "1"{
                cell.btnTrue.setBackgroundImage(#imageLiteral(resourceName: "t_greens"), for: .normal)
            }else {
                cell.btnFalse.setBackgroundImage(#imageLiteral(resourceName: "f_reds"), for: .normal)
            }
        }
        
        if isSearch{
            constraintHeightOfSearchView.constant = 46
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        
        return cell
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text.removeAll()
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
                        
                        if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController{
                            
                            selfVC.showAnswers = true
                            selfVC.questions = self.questions
                            nav.pushViewController(selfVC, animated: true)
                        }
                    }
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
    }
    
    func submitAnswers() {
        
        isSubmitted = true
        
        for section in 0..<tableView.numberOfSections {
            
            for row in 0..<tableView.numberOfRows(inSection: section){
                
                if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? TrueFalseTableViewCell{
                    
                    cell.btnTrue.isUserInteractionEnabled = false
                    cell.btnFalse.isUserInteractionEnabled = false
                    
                    if cell.selectedAnswer == Int(questions[row].answer){
                        
                        cell.tvContent.textColor = UIColor.green
                        
                    }else {
                        
                        cell.tvContent.textColor = UIColor.red
                    }
                }
            }
        }
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = (tableView.cellForRow(at: index) as? TrueFalseTableViewCell)?.btnFlag
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", btn?.questionId ?? "")
            
            if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first {
                print("\(fq)")
                btn?.flagValue = fq.flagValue
            }else {
                btn?.flagValue = 0
            }
        }
    }
    
    func shuffleQuestions(){
        
        showLoaderFor(view: self.view)
        self.questions.shuffle()
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        hideLoaderFor(view: self.view)
    }
    func searchThroughQuestions(){
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController{
                
                selfVC.showAnswers = true
                selfVC.isSearch = true
                selfVC.questions = self.questions
                selfVC.tempQuestions = self.questions
                nav.pushViewController(selfVC, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if searchTimer != nil{
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
            showLoaderFor(view: self.view)
            if let txt = textField.text?.trimmedText(){
                
                self.questions = self.tempQuestions.filter { (question) -> Bool in
                    return question.content.html2String.lowercased().contains(txt)
                }
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
                
            }else{
                
                self.questions = self.tempQuestions
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
            }
            hideLoaderFor(view: self.view)
        })
        
        
        return true
    }
}

//
//  VocabularyViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/26/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class VocabularyViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, AdvancedQuestion, UITextFieldDelegate {
    
    @IBOutlet var constraintHeightOfSearchView: NSLayoutConstraint!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    weak var containerDelegate : QuestionsContainerViewController?
    var isSearch = false
    var tempQuestions = [QuestionData]()
    var searchTimer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configuration()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if isSearch{
            constraintHeightOfSearchView.constant = 46
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("VocabularyUpdateFlag"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionDictationCell", for: indexPath) as! QuestionDictationTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvAnswer.text = questions[indexPath.row].answer.html2String
        cell.tvAnswer.isEditable = false
        
        (cell.btnFlag as! flagBtn).notificationName = "DictationUpdateFlag"
        (cell.btnFlag as! flagBtn).indexPath = indexPath
        (cell.btnFlag as! flagBtn).defaultImage = #imageLiteral(resourceName: "flag-blacked")
        (cell.btnFlag as! flagBtn).questionId = questions[indexPath.row].id
        let predicateQuery = NSPredicate.init(format: "Id == %@", questions[indexPath.row].id)
        if let fv = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first?.flagValue {
            
            (cell.btnFlag as! flagBtn).flagValue = fv
        }
        if cell.btnFlag.allTargets.count == 0{
            
            cell.btnFlag.addTarget(self, action: #selector(self.openEditFlagVC(_:)), for: .touchUpInside)
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
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = ((tableView.cellForRow(at: index) as? QuestionDictationTableViewCell)?.btnFlag as? flagBtn)
            
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
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionDictationVC") as? QuestionDictationViewController{
                
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
            if let txt = textField.text?.trimmedText(), textField.text!.trimmedText().count > 0{
                
                self.questions = self.tempQuestions.filter { (question) -> Bool in
                    return question.content.html2String.lowercased().contains(txt)
                }
                self.tableView.reloadData()
//                self.tableView.layoutIfNeeded()
                
            }else{
                
                self.questions = self.tempQuestions
                self.tableView.reloadData()
//                self.tableView.layoutIfNeeded()
            }
            hideLoaderFor(view: self.view)
        })
        
        
        return true
    }

}

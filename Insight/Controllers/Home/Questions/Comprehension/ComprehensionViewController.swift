//
//  ComprehensionViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/27/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class ComprehensionViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, CorrectedQuestion, AdvancedQuestion, UITextFieldDelegate{
    
    @IBOutlet var constraintHeightOfSearchView: NSLayoutConstraint!
    @IBOutlet var constraintHeightLblScore: NSLayoutConstraint!
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var tableView: IntinsicTableView!
    @IBOutlet var btnShowAnswer: UIButton!
    
    var questions = [QuestionData]()
    var showAnswers = false
    var isSubmitted = false
    weak var containerDelegate: QuestionsContainerViewController?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showAnswers{
            
            self.navigationController?.isNavigationBarHidden = false
            
        }
    }
    
    func configuration(){
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        tableView.register(UINib.init(nibName: "QuestionGeneralHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "QuestionGeneralHeader")
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
            
        }
        
        if isSearch{
            constraintHeightOfSearchView.constant = 46
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("ComprehensionUpdateFlag"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader") as! GeneralTableViewHeader
        
        headerView.tvContent.text = questions[section].content.html2String
        
        (headerView.btnFlag as! flagBtn).notificationName = "ComprehensionUpdateFlag"
        (headerView.btnFlag as! flagBtn).indexPath = IndexPath.init(row: 0, section: section)
        (headerView.btnFlag as! flagBtn).defaultImage = #imageLiteral(resourceName: "flag-noBG")
        (headerView.btnFlag as! flagBtn).questionId = questions[section].id
        let predicateQuery = NSPredicate.init(format: "Id == %@", questions[section].id)
        if let fv = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first?.flagValue {
            
            (headerView.btnFlag as! flagBtn).flagValue = fv
        }
        if headerView.btnFlag.allTargets.count == 0{
            
            headerView.btnFlag.addTarget(self, action: #selector(self.openEditFlagVC(_:)), for: .touchUpInside)
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].freewriting.count + questions[section].mcq.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var c = UITableViewCell.init()
        
        if indexPath.row < questions[indexPath.section].freewriting.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FreeWritingCell", for: indexPath) as! FreeWritingTableViewCell
            
            cell.tvContent.text = questions[indexPath.section].freewriting[indexPath.row].content.html2String
            
            cell.tvAnswer.isEditable = true
            
            if showAnswers {
                
                cell.tvAnswer.text = questions[indexPath.section].freewriting[indexPath.row].answer.html2String
                cell.tvAnswer.isEditable = false
            }
            
            c = cell
            
        }else if indexPath.row < (questions[indexPath.section].freewriting.count + questions[indexPath.section].mcq.count){
            
            let newIndexPath = IndexPath.init(row: indexPath.row - questions[indexPath.section].freewriting.count, section: indexPath.section)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMcqCell", for: indexPath) as! QuestionMcqTableViewCell
            
            cell.choices = questions[newIndexPath.section].mcq[newIndexPath.row].choices
            cell.correctAnswer = questions[newIndexPath.section].mcq[newIndexPath.row].answer
            cell.tvSubContent.text = questions[newIndexPath.section].mcq[newIndexPath.row].content
            
            if showAnswers {
                
                cell.tableChoices.isUserInteractionEnabled = false
                cell.showAnswer = true
            }
            
            c = cell
        }

        return c
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
                        
                        if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionComprehensionVC") as? ComprehensionViewController{
                            
                            selfVC.showAnswers = true
                            selfVC.questions = self.questions
                            nav.pushViewController(selfVC, animated: true)
                        }
                    }
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionComprehensionVC") as? ComprehensionViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
        
        
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = (tableView.headerView(forSection: index.section) as? GeneralTableViewHeader)?.btnFlag as? flagBtn
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", btn?.questionId ?? "")
            
            if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first {
                print("\(fq)")
                btn?.flagValue = fq.flagValue
            }else {
                btn?.flagValue = 0
            }
        }
    }
    
    func submitAnswers() {
        
        isSubmitted = true
        var questionsCounter = 0
        var correctAnswersCounter = 0
        
        for section in 0..<tableView.numberOfSections{
            
            questionsCounter += 1
            
            var answersIsCorrect = true
            
            for row in 0..<tableView.numberOfRows(inSection: section){
                
                if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? FreeWritingTableViewCell{
                    
                    if cell.tvAnswer.text.trimmedText().lowercased() != questions[section].freewriting[row].content.html2String.lowercased(){
                        
                        answersIsCorrect = false
                        break
                    }
                    
                }else if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionMcqTableViewCell{
                    
                    cell.tableChoices.isUserInteractionEnabled = false
                    
                    if let indexOfSelectedAnswer = cell.tableChoices.indexPathForSelectedRow{
                        
                        if indexOfSelectedAnswer.row != Int(cell.correctAnswer){
                            
                            answersIsCorrect = false
                            break
                        }
                    }
                }
            }
            
            if answersIsCorrect {
                
                correctAnswersCounter += 1
            }
        }
        if containerDelegate != nil {
            containerDelegate?.updateScore(total: questionsCounter, score: correctAnswersCounter)
        }
        
        constraintHeightLblScore.constant = 94
        lblScore.layer.cornerRadius = (lblScore.frame.width + 1) / 2
        lblScore.layer.borderWidth = 4
        lblScore.layer.borderColor = UIColor.white.cgColor
        lblScore.text = "\(correctAnswersCounter) / \(questionsCounter)"
        
        showAlert(title: "", message: "Your score: \(correctAnswersCounter)\nTotal score: \(questionsCounter)", vc: self, closure: nil)
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
            
            if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionComprehensionVC") as? ComprehensionViewController{
                
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

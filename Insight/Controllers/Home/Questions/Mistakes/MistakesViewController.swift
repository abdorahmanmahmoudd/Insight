//
//  MistakesViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MistakesViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, CorrectedQuestion {
    
    @IBOutlet var constraintHeightLblScore: NSLayoutConstraint!
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var tableView: IntinsicTableView!
    @IBOutlet var btnShowAnswer : UIButton!
    
    var questions = [QuestionData]()
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
    
    func configuration(){
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        tableView.register(UINib.init(nibName: "QuestionGeneralHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "QuestionGeneralHeader")
        
        if showAnswers {
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("MistakesUpdateFlag"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader") as! GeneralTableViewHeader
        
        headerView.tvContent.text = questions[section].content.html2String
        
        (headerView.btnFlag as! flagBtn).notificationName = "MistakesUpdateFlag"
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
        return questions[section].mistakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMistakeCell", for: indexPath) as! MistakesTableViewCell
        
        cell.tvAnswer.delegate = self
        cell.tvMistake.delegate = self
        
        if showAnswers {
        
            cell.tvMistake.text = questions[indexPath.section].mistakes[indexPath.row].content.html2String
            cell.tvAnswer.text = questions[indexPath.section].mistakes[indexPath.row].answer.html2String
            
            cell.tvAnswer.isEditable = false
            cell.tvMistake.isEditable = false
            
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
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMistakesVC") as? MistakesViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
    }
    
    func submitAnswers() {
        
        self.isSubmitted = true
        var questionsCounter = 0
        var correctAnswersCounter = 0
        
        for section in 0..<self.tableView.numberOfSections {
            
            for row in 0..<self.tableView.numberOfRows(inSection: section){
                
                if let cell = self.tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? MistakesTableViewCell{
                    
                    cell.tvAnswer.isEditable = false
                    cell.tvMistake.isEditable = false
                    questionsCounter += 1
                    
                    if cell.tvAnswer.text.trimmedText().lowercased() == self.questions[section].mistakes[row].answer.html2String.lowercased() && cell.tvMistake.text.trimmedText().lowercased() == self.questions[section].mistakes[row].content.html2String.lowercased(){
                        
                        cell.tvAnswer.textColor = UIColor.green
                        correctAnswersCounter += 1
                        
                    }else {
                        cell.tvAnswer.textColor = UIColor.red
                    }
                }
            }
        }
        if containerDelegate != nil {
            containerDelegate?.updateScore(total: questionsCounter, score: correctAnswersCounter)
        }
        
        self.constraintHeightLblScore.constant = 94
        self.lblScore.layer.cornerRadius = (self.lblScore.frame.width + 1) / 2
        self.lblScore.layer.borderWidth = 4
        self.lblScore.layer.borderColor = UIColor.white.cgColor
        self.lblScore.text = "\(correctAnswersCounter) / \(questionsCounter)"
        
        showAlert(title: "", message: "Your score: \(correctAnswersCounter)\nTotal score: \(questionsCounter)", vc: self, closure: nil)
    }
    
    //MARK: to update flag
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

}

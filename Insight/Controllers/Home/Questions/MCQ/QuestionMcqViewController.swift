//
//  QuestionMcqViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMcqViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, CorrectedQuestion {
    
    @IBOutlet var constraintHeightLblScore: NSLayoutConstraint!
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var tableQuestions: IntinsicTableView!
    @IBOutlet var btnShowAnswer: UIButton!
    
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
        
        tableQuestions.sectionHeaderHeight = UITableViewAutomaticDimension
        tableQuestions.estimatedSectionHeaderHeight = 300
        
        tableQuestions.rowHeight = UITableViewAutomaticDimension
        tableQuestions.estimatedRowHeight = 500
        
        tableQuestions.register(UINib.init(nibName: "QuestionGeneralHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "QuestionGeneralHeader")
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("MCQUpdateFlag"), object: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableQuestions.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader") as! GeneralTableViewHeader
        
        headerView.tvContent.text = questions[section].content.html2String
        
        (headerView.btnFlag as! flagBtn).notificationName = "MCQUpdateFlag"
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
        return questions[section].choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMcqCell", for: indexPath) as! QuestionMcqTableViewCell
        
        cell.choices = questions[indexPath.section].choices[indexPath.row].choices
        cell.correctAnswer = questions[indexPath.section].choices[indexPath.row].answer
        
        if showAnswers {
            
            cell.tableChoices.isUserInteractionEnabled = false
            cell.showAnswer = true
        }
        
        return cell
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
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMCQVC") as? QuestionMcqViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
       
        
    }
    
    
    func submitAnswers() {
        
        isSubmitted = true
        var questionsCounter = 0
        var correctAnswersCounter = 0
        
        for section in 0..<tableQuestions.numberOfSections{
            
            for row in 0..<tableQuestions.numberOfRows(inSection: section){
                
                if let cell = tableQuestions.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionMcqTableViewCell{
                    
                    questionsCounter += 1
                    
                    cell.tableChoices.allowsSelection = false
                    
                    if let indexOfSelectedAnswer = cell.tableChoices.indexPathForSelectedRow{
                        
                        if indexOfSelectedAnswer.row + 1 == Int(cell.correctAnswer){
                            
                            correctAnswersCounter += 1
                        }
                    }
                }
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
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = (tableQuestions.headerView(forSection: index.section) as? GeneralTableViewHeader)?.btnFlag as? flagBtn
            
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

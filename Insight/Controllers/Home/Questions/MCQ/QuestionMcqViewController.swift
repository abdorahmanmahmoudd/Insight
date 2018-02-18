//
//  QuestionMcqViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMcqViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, CorrectedQuestion {
    
    @IBOutlet var tableQuestions: IntinsicTableView!
    @IBOutlet var btnShowAnswer: UIButton!
    
    var questions = [QuestionData]()
    var showAnswers = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableQuestions.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader")
        
        (headerView as? GeneralTableViewHeader)?.tvContent.text = questions[section].content.html2String
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMcqCell", for: indexPath) as! QuestionMcqTableViewCell
        
        cell.choices = questions[indexPath.section].choices[indexPath.row].choices
        cell.correctAnswer = questions[indexPath.section].choices[indexPath.row].answer
        cell.tableChoices.allowsSelection = true
        
        if showAnswers {
            
            cell.tableChoices.allowsSelection = false
            let ip = IndexPath.init(row: 0, section: indexPath.section)
            cell.tableChoices.selectRow(at: ip, animated: false, scrollPosition: UITableViewScrollPosition.none)
        }
        
        return cell
    }
    

    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMCQVC") as? QuestionMcqViewController{
                
                selfVC.showAnswers = true
                selfVC.questions = self.questions
                nav.pushViewController(selfVC, animated: true)
            }
        }
    }
    
    
    func submitAnswers() {
        
        var correctAnswersCounter = 0
        
        for section in 0..<tableQuestions.numberOfSections{
            
            for row in 0..<tableQuestions.numberOfRows(inSection: section){
                
                if let cell = tableQuestions.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionMcqTableViewCell{
                    
                    cell.tableChoices.allowsSelection = false
                    
                    if let indexOfSelectedAnswer = cell.tableChoices.indexPathForSelectedRow{
                        
                        if indexOfSelectedAnswer.row == Int(cell.correctAnswer){
                            
                            correctAnswersCounter += 1
                        }
                    }
                }
            }
        }
        
        print("number of correct asnwers: \(correctAnswersCounter)")
        
    }

}

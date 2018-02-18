//
//  TrueFalseViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class TrueFalseViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource , UITextViewDelegate, CorrectedQuestion{
    
    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    var showAnswers = false
    
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
    
        tableView.rowHeight = 112
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTrueFlaseCell", for: indexPath) as! TrueFalseTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvAnswer.isEditable = true
        
        if showAnswers{
            
            cell.tvAnswer.text = questions[indexPath.row].answerContent?.html2String ?? ""
            cell.tvAnswer.isEditable = false
            if questions[indexPath.row].answer == "0"{
                cell.btnTrue.backgroundColor = UIColor.green
            }else {
                cell.btnFalse.backgroundColor = UIColor.red
            }
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
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController{
                
                selfVC.showAnswers = true
                selfVC.questions = self.questions
                nav.pushViewController(selfVC, animated: true)
            }
        }
    }
    
    func submitAnswers() {
        
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
}

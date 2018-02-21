//
//  QuestionCompleteViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionCompleteViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, CorrectedQuestion, UITextViewDelegate {

    @IBOutlet var btnShowAnswer: UIButton!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    var showAnswers = false
    
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
        
        if showAnswers {
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCompleteCell", for: indexPath) as! QuestionCompleteTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvVerb.text = questions[indexPath.row].verb.html2String
        cell.tvAnswer.isEditable = true
        
        if showAnswers {
            
            cell.tvAnswer.text = questions[indexPath.row].answer.html2String
            cell.tvAnswer.isEditable = false
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

    @IBAction func btnShowAnswer(_ sender: UIButton) {
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionCompleteVC") as? QuestionCompleteViewController{
                
                selfVC.showAnswers = true
                selfVC.questions = self.questions
                nav.pushViewController(selfVC, animated: true)
            }
        }
    }
    
    func submitAnswers() {
        
        for section in 0..<tableView.numberOfSections {
            
            for row in 0..<tableView.numberOfRows(inSection: section){
                
                if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionCompleteTableViewCell{
                    
                    cell.tvAnswer.isEditable = false
                    
                    if cell.tvAnswer.text.trimmedText().lowercased() == questions[row].answer.html2String.lowercased(){
                        
                        cell.tvAnswer.textColor = UIColor.green
                        
                    }else {
                        
                        cell.tvAnswer.textColor = UIColor.red
                    }
                }
            }
        }
        
    }
    

}

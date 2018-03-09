//
//  AntonymQViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class AntonymQViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, CorrectedQuestion {

    @IBOutlet var tableView: IntinsicTableView!
    @IBOutlet var btnShowAnswer: UIButton!
    
    var questions = [QuestionData]()
    var showAnswers = false
    var isSubmitted = false
    weak var containerDelegate : QuestionsContainerViewController?
    
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
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("AntonymUpdateFlag"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AntonymQuestionCell", for: indexPath) as! QuestionAntonymTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvAnswer.isEditable = true
        
        (cell.btnFlag as! flagBtn).notificationName = "AntonymUpdateFlag"
        (cell.btnFlag as! flagBtn).indexPath = indexPath
        (cell.btnFlag as! flagBtn).defaultImage = #imageLiteral(resourceName: "flag-noBG")
        (cell.btnFlag as! flagBtn).questionId = questions[indexPath.row].id
        let predicateQuery = NSPredicate.init(format: "Id == %@", questions[indexPath.row].id)
        if let fv = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first?.flagValue {
            
            (cell.btnFlag as! flagBtn).flagValue = fv
        }
        if cell.btnFlag.allTargets.count == 0{
            
            cell.btnFlag.addTarget(self, action: #selector(self.openEditFlagVC(_:)), for: .touchUpInside)
        }
        
        if showAnswers{
            
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
    
    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        
        if !self.isSubmitted{
            
            showYesNoAlert(title: "", message: "Do you want to submit your answers?", vc: self) { (submit) in
                if submit{
                    if self.containerDelegate != nil{
                        
                        self.containerDelegate?.submitQuestion()
                    }
                }else{
                    if let nav = self.parent?.navigationController {
                        
                        if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionAntonymVC") as? AntonymQViewController{
                            
                            selfVC.showAnswers = true
                            selfVC.questions = self.questions
                            nav.pushViewController(selfVC, animated: true)
                        }
                    }
                    
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionAntonymVC") as? AntonymQViewController{
                    
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
                
                if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionAntonymTableViewCell{
                    
                    cell.tvAnswer.isEditable = false
                    
                    if cell.tvAnswer.text.trimmedText().lowercased() == questions[row].answer.html2String.lowercased(){
                        
                        cell.tvAnswer.textColor = UIColor.green
                        cell.tvContent.textColor = UIColor.green
                        
                    }else {
                        
                        cell.tvAnswer.textColor = UIColor.red
                        cell.tvContent.textColor = UIColor.red
                    }
                }
            }
        }
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = ((tableView.cellForRow(at: index) as? QuestionAntonymTableViewCell)?.btnFlag as? flagBtn)
            
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

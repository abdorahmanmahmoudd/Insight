//
//  QuestionMatchViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMatchViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, CorrectedQuestion, AdvancedQuestion, UITextFieldDelegate {

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
    
    var tempAnswersArray = [String]()
    var shuffledAnswers = [String]()
    var correctAnswersIndices = [Int]()
    
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
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        if isSearch{
            constraintHeightOfSearchView.constant = 46
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("MatchUpdateFlag"), object: nil)
        
        for item in questions{
            tempAnswersArray.append(item.answer)
        }
        for _ in 0..<tempAnswersArray.count
        {
            let rand = Int(arc4random_uniform(UInt32(tempAnswersArray.count)))
            
            correctAnswersIndices.append(rand)
            
            shuffledAnswers.append(tempAnswersArray[rand])
            
            tempAnswersArray.remove(at: rand)
            
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMatchCell", for: indexPath) as! QuestionMatchTableViewCell
        
        cell.tvContent.text = "\(indexPath.row + 1)- \(questions[indexPath.row].content.html2String)"
        cell.tvAnswer.text = shuffledAnswers[indexPath.row].html2String
        cell.tfAnswerNumber.isEnabled = true
        
        (cell.btnFlag as! flagBtn).notificationName = "MatchUpdateFlag"
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
        
        if showAnswers {
            
            cell.tvAnswer.text = questions[indexPath.row].answer.html2String
            cell.tfAnswerNumber.text = String(indexPath.row + 1)
            cell.tfAnswerNumber.isEnabled = false
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
                }else{
                    
                    if let nav = self.parent?.navigationController {
                        
                        if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController{
                            
                            selfVC.showAnswers = true
                            selfVC.questions = self.questions
                            nav.pushViewController(selfVC, animated: true)
                        }
                    }
                }
            }
            
        }else{
            
            if let nav = self.parent?.navigationController {
                
                if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController{
                    
                    selfVC.showAnswers = true
                    selfVC.questions = self.questions
                    nav.pushViewController(selfVC, animated: true)
                }
            }
        }
    }
    
    func submitAnswers() {
        
        self.isSubmitted = true
        
        for section in 0..<tableView.numberOfSections {
            
            for row in 0..<tableView.numberOfRows(inSection: section){
                
                if let cell = tableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? QuestionMatchTableViewCell{
                    
                    cell.tfAnswerNumber.isEnabled = false
                    
                    if let i = Int(cell.tfAnswerNumber.text ?? "0"), (i - 1) >= 0 , (i - 1) < questions.count{
                        
                        if questions[i - 1].answer.html2String.lowercased() == cell.tvAnswer.text.lowercased(){
                            
                            cell.tvAnswer.textColor = UIColor.green
                            
                        }else {
                            
                            cell.tvAnswer.textColor = UIColor.red
                        }
                    }else {
                        
                        cell.tvAnswer.textColor = UIColor.red
                    }
                }
            }
        }
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = ((tableView.cellForRow(at: index) as? QuestionMatchTableViewCell)?.btnFlag as? flagBtn)
            
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
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController{
                
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

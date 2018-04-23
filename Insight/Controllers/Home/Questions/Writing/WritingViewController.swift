//
//  WritingViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class WritingViewController: ParentViewController,UITableViewDelegate, UITableViewDataSource, AdvancedQuestion, UITextFieldDelegate {
    
    @IBOutlet var constraintHeightOfSearchView: NSLayoutConstraint!
    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
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
        tableView.estimatedRowHeight = 500
        if isSearch{
            constraintHeightOfSearchView.constant = 46
            self.navigationController?.isNavigationBarHidden = false
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("WritingUpdateFlag"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionWritingCell", for: indexPath) as! WritingTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        
        cell.btnFlag.notificationName = "WritingUpdateFlag"
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
        
        return cell
    }
    

    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = (tableView.cellForRow(at: index) as? WritingTableViewCell)?.btnFlag
            
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
            
            if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionWritingVC") as? WritingViewController{
                
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

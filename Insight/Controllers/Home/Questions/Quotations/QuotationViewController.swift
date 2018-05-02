//
//  QuotationViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/9/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuotationViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, AdvancedQuestion, UITextFieldDelegate {
    
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
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        if isSearch{
            constraintHeightOfSearchView.constant = 46
            self.navigationController?.isNavigationBarHidden = false
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        
        tableView.register(UINib.init(nibName: "QuestionGeneralHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "QuestionGeneralHeader")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("QuotationUpdateFlag"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionGeneralHeader") as! GeneralTableViewHeader
        
        headerView.tvContent.text = questions[section].content.html2String
        
        (headerView.btnFlag as! flagBtn).notificationName = "QuotationUpdateFlag"
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
        return questions[section].questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionQuotationCell", for: indexPath) as! QuotationTableViewCell
        
        cell.tvContent.text = questions[indexPath.section].questions[indexPath.row].content.html2String
        
        return cell
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n"{
            print("new line")
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text.removeAll()
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
    
    func shuffleQuestions(){
        
        showLoaderFor(view: self.view)
        self.questions.shuffle()
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        hideLoaderFor(view: self.view)
    }
    func searchThroughQuestions(){
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionQuotationVC") as? QuotationViewController{
                
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

//
//  MiniDialogViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/7/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogViewController: ParentViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, AdvancedQuestion, UITextFieldDelegate{

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
        tableView.estimatedRowHeight = 300
        if isSearch{
            constraintHeightOfSearchView.constant = 46
            self.navigationController?.isNavigationBarHidden = false
        }else{
            constraintHeightOfSearchView.constant = 0
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRow(_:)), name: NSNotification.Name("MiniDialogUpdateFlag"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMiniDialogCell", for: indexPath) as! MiniDialogTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.cellIndex = indexPath.row
        cell.tvPlaceAnswer.delegate = self
        cell.tvSpeakerAA.delegate = self
        cell.tvSpeakerBA.delegate = self
        cell.tvFunctionAA.delegate = self
        cell.tvFunctionBA.delegate = self
        cell.showAnswerHandler = { [weak self] in
            
            self?.showAnswerHandler(cell: $0)
        }
        
        cell.btnFlag.notificationName = "MiniDialogUpdateFlag"
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
    
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text.removeAll()
    }
    
    func showAnswerHandler(cell: MiniDialogTableViewCell){
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MiniDialogAnswersVC") as? MiniDialogAnswersViewController{
            
            vc.spaceText = questions[cell.cellIndex].content
            vc.speakerAText = questions[cell.cellIndex].speakera
            vc.speakerBText = questions[cell.cellIndex].speakerb
            vc.functionAText = questions[cell.cellIndex].functiona
            vc.functionBText = questions[cell.cellIndex].functionb
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func updateRow(_ notification: NSNotification){
        
        if let index = notification.userInfo?["indexPath"] as? IndexPath{
            
            print("\(index)")
            
            let btn = (tableView.cellForRow(at: index) as? MiniDialogTableViewCell)?.btnFlag
            
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
            
            if let selfVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionMiniDialogVC") as? MiniDialogViewController{
                
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

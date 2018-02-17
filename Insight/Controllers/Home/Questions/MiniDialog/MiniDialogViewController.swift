//
//  MiniDialogViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/7/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class MiniDialogViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

    @IBOutlet var tableView: IntinsicTableView!
    
    var questions = [QuestionData]()
    
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
    
}

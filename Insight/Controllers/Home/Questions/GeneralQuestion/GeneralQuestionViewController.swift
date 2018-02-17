//
//  GeneralQuestionViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class GeneralQuestionViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

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
        tableView.estimatedRowHeight = 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralQuestionCell", for: indexPath) as! GeneralQuestionTableViewCell
        
        cell.tvContent.text = questions[indexPath.row].content.html2String
        cell.tvAnswer.delegate = self
        cell.cellIndex = indexPath.row
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
    
    func showAnswerHandler(cell: GeneralQuestionTableViewCell){
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralQuestionAnswersVC") as? GeneralQuestionAnswersViewController{
            
            vc.answerText = questions[cell.cellIndex].answer.html2String
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }

}

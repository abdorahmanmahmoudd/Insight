//
//  QuestionMatchViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/5/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionMatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if showAnswers{
            
            btnShowAnswer.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionMatchCell", for: indexPath) as! QuestionMatchTableViewCell
        
        cell.fillData(question: questions[indexPath.row])
        
        cell.tfAnswerNumber.isEnabled = true
        
        if showAnswers {
            
            cell.tfAnswerNumber.isEnabled = false
        }
        
        return cell
    }
    
    @IBAction func btnShowAnswerClicked(_ sender: UIButton) {
        
        if let nav = self.parent?.navigationController {
            
            if let selfVC = storyboard?.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController{
                
                selfVC.showAnswers = true
                selfVC.questions = self.questions
                nav.pushViewController(selfVC, animated: true)
            }
        }
    }

}
